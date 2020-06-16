#include <stdio.h>
#include <unistd.h>
#include <pthread.h> 
#include <stdlib.h>
#include <sys/time.h>
#include "queue.h"

#define FCFS 0
#define ROUND_ROBIN 1 


int producer_threads, consumer_threads, num_products, queue_size, scheduling_alg, quantum, seed;
Queue* product_queue;
int products_generated = 0;
int products_consumed = 0;

pthread_mutex_t product_mutex;
pthread_mutex_t consumer_mutex;
pthread_cond_t producer_lock = PTHREAD_COND_INITIALIZER;
pthread_cond_t consumer_lock = PTHREAD_COND_INITIALIZER;

void* producer_start(void*);
void* consumer_start(void*);
int gen_product_life();
int fib(int);

int main(int argc, char *argv[]) {
    if(argc != 8) {
      fprintf(stderr, "Invalid number of arguments: expected 7, got %d.\n", argc-1);
      exit(1);
    }

    // Parse args
    if(sscanf(argv[1], "%i", &producer_threads) != 1) {
      fprintf(stderr, "Argument 1 (producer threads) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[2], "%i", &consumer_threads) != 1) {
      fprintf(stderr, "Argument 2 (consumer threads) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[3], "%i", &num_products) != 1) {
      fprintf(stderr, "Argument 3 (number of products) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[4], "%i", &queue_size) != 1) {
      fprintf(stderr, "Argument 4 (queue size) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[5], "%i", &scheduling_alg) != 1) {
      fprintf(stderr, "Argument 5 (scheduling algorithm) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[6], "%i", &quantum) != 1) {
      fprintf(stderr, "Argument 6 (quantum) is not a parsable integer.\n");
      exit(1);
    }
    if(sscanf(argv[7], "%i", &seed) != 1) {
      fprintf(stderr, "Argument 7 (seed) is not a parsable integer.\n");
      exit(1);
    }

    // Validate args
    if(producer_threads < 0) {
      fprintf(stderr, "Invalid number of producer threads (%d).\n", producer_threads);
      exit(1);
    }
    if(consumer_threads < 0) {
      fprintf(stderr, "Invalid number of consumer threads (%d).\n", consumer_threads);
      exit(1);
    }
    if(num_products < 0) {
      fprintf(stderr, "Invalid number of products (%d).\n", num_products);
      exit(1);
    }
    if(queue_size < 0) {
      fprintf(stderr, "Invalid queue size (%d).\n", queue_size);
      exit(1);
    }
    if(scheduling_alg != FCFS && scheduling_alg != ROUND_ROBIN) {
      fprintf(stderr, "Invalid scheduling_alg (%d).\n", scheduling_alg);
      exit(1);
    }
    if(quantum < 0) {
      fprintf(stderr, "Invalid quantum size (%d).\n", quantum);
      exit(1);
    }
    if(seed < 0) {
      fprintf(stderr, "Invalid seed (%d).\n", seed);
      exit(1);
    }

    // Print out all args
    printf("Using args:\n");
    printf("\tProducer threads: %d\n", producer_threads);
    printf("\tConsumer threads: %d\n", consumer_threads);
    printf("\tNumber of Products: %d\n", num_products);
    printf("\tQueue size: %d", queue_size);
    if(queue_size == 0) {
      printf(" (infinite)");
    }
    printf("\n");
    printf("\tScheduling Algorithm: %d", scheduling_alg);
    if(scheduling_alg == FCFS) {
      printf(" (First-Come-First-Serve)\n");
    } else {
      printf(" (Round-Robin)\n");
    }
    printf("\tQuantum: %d\n", quantum);
    printf("\tSeed: %d\n", seed);

    // Seed random
    srandom(seed);

    // Init queue
    product_queue = create_queue(queue_size);

    // Create producer threads
    pthread_t* producers = (pthread_t*) malloc(producer_threads * sizeof(pthread_t));
    int* prod_ids = (int*) malloc(producer_threads * sizeof(int));
    for(int i = 0; i < producer_threads; i++) {
      prod_ids[i] = i;
      pthread_create(&(producers[i]), NULL, producer_start, &prod_ids[i]);
    }

    // Create consumer threads
    pthread_t* consumers = (pthread_t*) malloc(consumer_threads * sizeof(pthread_t));
    for(int i = 0; i < consumer_threads; i++) {
      pthread_create(&(consumers[i]), NULL, consumer_start, NULL);
    }

    // Wait for threads to finish
    for(int i = 0; i < producer_threads; i++)
      pthread_join(producers[i], NULL);

    for(int i = 0; i < consumer_threads; i++)
      pthread_join(consumers[i], NULL);

    // Clean up memory
    free(producers);
    free(consumers);
    free(prod_ids);
    free(product_queue);

    pthread_exit(0);
}

// Entry point for producer treads
void* producer_start(void* id) {
  int producer_id = *(int*)id;

  while(products_generated < num_products) {

    pthread_mutex_lock(&product_mutex);
    // If the queue is full, stop all producers
    while(product_queue->size == product_queue->max_size && product_queue->max_size != 0) {
      pthread_cond_wait(&producer_lock, &product_mutex);
    }

    // Generate a new product
    if(products_generated < num_products) {
      Product* p = (Product*) malloc(sizeof(Product));
      p->id = products_generated;
      p->timestamp = (int) clock(); // We use clock here rather than gettimeofday() in order to get higher resolution on the value
      p->life = gen_product_life();
      products_generated++;

      enqueue(product_queue, p);
      printf("Producer %d has produced product: { id:%d, timestamp:%d, life:%d } (Products in queue: %d/%d)\n", producer_id, p->id, p->timestamp, p->life, product_queue->size, product_queue->max_size);

      // Wake up the consumers if they may have been sleeping
      if(product_queue->size == 1) {
        pthread_cond_signal(&consumer_lock);
      }
    }
    pthread_mutex_unlock(&product_mutex);

    usleep(100000);
  }

  printf("Producer %d terminating...\n", producer_id);
  pthread_exit(NULL);
}

// Entry point for consumer threads 
void* consumer_start(void* id){
  int cons_id = *(int*)id;
  while(products_consumed < num_products)
  {
    pthread_mutex_lock(&consumer_mutex);
    //if the queue is empty, stop all consumers
    while(product_queue->size == 0)
	pthread_cond_wait(&consumer_lock, &consumer_mutex);

    if(products_consumed < num_products){
      Product* p = dequeue(product_queue);
      for(int i=0; i<p->life; i++)
        fib(10);
      products_consumed++;
      printf("Consumer %d has consumed product: id:%d\n", cons_id, p->id); 
      product_queue->size -=1;
      // Wake up producers 
      if(product_queue->size == 0){
  	  pthread_cond_signal(&producer_lock);
      }
    }
    pthread_mutex_unlock(&consumer_mutex);
    usleep(100000);
  }

  printf("Consumer %d is terminating...\n", cons_id);
  pthread_exit(NULL);
}

//fibonacci function to simulate consumption of product
int fib(int num){
  if(num<=1)
    return num;
  else return fib(num-1) + fib(num-2);
}

// Generates a random product life in the range [0, 1024)
int gen_product_life() {
  return random() % 1024;
}
