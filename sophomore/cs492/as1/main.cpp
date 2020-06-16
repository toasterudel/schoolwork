/*
* John Banya and Christopher Rudel
* "I pledge my honor that I have abided by the Stevens Honor System."
*/

#include <stdio.h>
#include <unistd.h>
#include <pthread.h> 
#include <stdlib.h>
#include "queue.h"

#define FCFS 0
#define ROUND_ROBIN 1 


int producer_threads, consumer_threads, num_products, queue_size, scheduling_alg, quantum, seed;
Queue* product_queue;
int products_generated = 0;
int products_consumed = 0;

// Turn around time vars
double min_turn_around = -1.0;
double max_turn_around = -1.0;
double total_turn_around = 0.0;

// Wait time vars
double min_wait_time = -1.0;
double max_wait_time = -1.0;
double total_wait_time = 0.0;
int num_waits = 0;

// Producer and consumer throughput vars
double producer_start_time = 0.0;
double producer_end_time = 0.0;
double consumer_start_time = 0.0;
double consumer_end_time = 0.0;

// Thread-safety vars
pthread_mutex_t product_mutex;
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

    // Seed random
    srandom(seed);

    // Init queue
    product_queue = create_queue(queue_size);

    // Initialize start time
    struct timespec start_time;
    clock_gettime(CLOCK_MONOTONIC, &start_time);

    // Create producer threads
    producer_start_time = (double)start_time.tv_sec + (double)start_time.tv_nsec / 1000000000.0;

    pthread_t* producers = (pthread_t*) malloc(producer_threads * sizeof(pthread_t));
    int* prod_ids = (int*) malloc(producer_threads * sizeof(int));
    for(int i = 0; i < producer_threads; i++) {
      prod_ids[i] = i;
      if(pthread_create(&(producers[i]), NULL, producer_start, &prod_ids[i]) != 0) {
        printf("Unable to create producer thread! Aborting...\n");
        exit(1);
      }
    }

    // Create consumer threads
    struct timespec start_consumers;
    clock_gettime(CLOCK_MONOTONIC, &start_consumers);
    consumer_start_time = (double)start_consumers.tv_sec + (double)start_consumers.tv_nsec / 1000000000.0;

    pthread_t* consumers = (pthread_t*) malloc(consumer_threads * sizeof(pthread_t));
    int* con_ids = (int*) malloc(consumer_threads * sizeof(int));
    for(int i = 0; i < consumer_threads; i++) {
      con_ids[i] = i;
      if(pthread_create(&(consumers[i]), NULL, consumer_start, &con_ids[i]) != 0) {
        printf("Unable to create consumer thread! Aborting...\n");
        exit(1);
      }
    }

    // Wait for threads to finish
    for(int i = 0; i < producer_threads; i++)
      pthread_join(producers[i], NULL);

    for(int i = 0; i < consumer_threads; i++)
      pthread_join(consumers[i], NULL);

    // Initialize emd time
    struct timespec end_time;
    clock_gettime(CLOCK_MONOTONIC, &end_time);

    // Print out statistics
    printf("\n");
    printf("_____________________STATISTICS___________________________\n");
    printf("|\n");
    printf("|\t\e[1mProducer threads:\e[21m %d\n", producer_threads);
    printf("|\t\e[1mConsumer threads:\e[21m %d\n", consumer_threads);
    printf("|\t\e[1mNumber of Products:\e[21m %d\n", num_products);
    printf("|\t\e[1mQueue size:\e[21m %d", queue_size);
    if(queue_size == 0) {
      printf(" (infinite)");
    }
    printf("\n");
    printf("|\t\e[1mScheduling Algorithm:\e[21m %d", scheduling_alg);
    if(scheduling_alg == FCFS) {
      printf(" (First-Come-First-Serve)\n");
    } else {
      printf(" (Round-Robin)\n");
    }
    printf("|\t\e[1mQuantum:\e[21m %d\n", quantum);
    printf("|\t\e[1mSeed:\e[21m %d\n", seed);
    printf("|\n");
    printf("|\t---\n");
    printf("|\n");
    printf("|\t\e[1mTotal run time:\e[21m %f seconds\n", ((double)end_time.tv_sec + (double)end_time.tv_nsec / 1000000000.0) - ((double)start_time.tv_sec + (double)start_time.tv_nsec / 1000000000.0));
    printf("|\t\n");
    printf("|\t\e[1mMinimum turn-around time:\e[21m %f seconds\n", min_turn_around);
    printf("|\t\e[1mMaximum turn-around time:\e[21m %f seconds\n", max_turn_around);
    printf("|\t\e[1mAverage turn-around time:\e[21m %f seconds (%f/%d)\n", total_turn_around / num_products, total_turn_around, num_products);
    printf("|\n");
    printf("|\t\e[1mMinimum wait time:\e[21m %f seconds\n", min_wait_time);
    printf("|\t\e[1mMaximum wait time:\e[21m %f seconds\n", max_wait_time);
    printf("|\t\e[1mAverage wait time:\e[21m %f seconds (%f/%d)\n", total_wait_time / num_waits, total_wait_time, num_waits);
    printf("|\t\n");
    printf("|\t\e[1mProducer throughput:\e[21m %f products/min\n", num_products / (producer_end_time - producer_start_time) * 60.0);
    printf("|\t\e[1mConsumer throughput:\e[21m %f products/min\n", num_products / (consumer_end_time - consumer_start_time) * 60.0);
    printf("|__________________________________________________________\n");
    printf("\n");
    fflush(stdout);

    // Clean up memory
    free(producers);
    free(consumers);
    free(prod_ids);
    free(con_ids);
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
      
      // Get product timestamp
      struct timespec ts;
      clock_gettime(CLOCK_MONOTONIC, &ts); // clock_gettime is the successor to gettimeofday(). We use this instead for higher precision.

      // Create additonal product info
      p->id = products_generated;
      p->timestamp = (double)ts.tv_sec + ((double)ts.tv_nsec / 1000000000.0);
      p->life = random() % 1024;
      products_generated++;

      enqueue(product_queue, p);
      printf("\e[96m[P] Producer %d has produced product: { id:%d, timestamp:%f, life:%d } (Products in queue: %d/%d)\e[39m\n", producer_id, p->id, p->timestamp, p->life, product_queue->size, product_queue->max_size);

      // Wake up the consumers if they may have been sleeping
      if(product_queue->size == 1) {
        pthread_cond_broadcast(&consumer_lock);
      }
    }
    pthread_mutex_unlock(&product_mutex);
    usleep(100000);
  }

  printf("Producer %d terminating...\n", producer_id);

  // The last thread exiting will set the final value of the producer end time
  struct timespec producer_end;
  clock_gettime(CLOCK_MONOTONIC, &producer_end);
  producer_end_time = (double)producer_end.tv_sec + ((double)producer_end.tv_nsec / 1000000000.0);

  pthread_exit(NULL);
}

// Entry point for consumer threads
void* consumer_start(void* id) {
  int consumer_id = *(int*)id;

  while(products_consumed < num_products) {

    pthread_mutex_lock(&product_mutex);
    while(product_queue->size == 0 && products_consumed < num_products) {
      // Sleep if no products are in queue and products are still going to be generated
      pthread_cond_wait(&consumer_lock, &product_mutex);
    }

    if(scheduling_alg == FCFS) { // Implements the first-come-first-serve algorithm by removing the first item in the queue.
      Product* p = dequeue(product_queue);
      if(p != NULL) {

        // Calculate and track wait time
        struct timespec now_wt;
        clock_gettime(CLOCK_MONOTONIC, &now_wt);
        double wait_time = ((double)now_wt.tv_sec + (double)now_wt.tv_nsec / 1000000000.0) - p->time_added;
        if(wait_time < min_wait_time || min_wait_time <= 0.0) min_wait_time = wait_time;
        if(wait_time > max_wait_time || max_wait_time <= 0.0) max_wait_time = wait_time;
        total_wait_time += wait_time;
        num_waits++;

        // Consume the product
        for(int i = 0; i < p->life; i++) {
          fib(10); // Simulates product consumption by calling fn(10) 'life' times as specified in the hw, N * fn(10) 
        }
        
        // Calculate and track turn-around time
        struct timespec now_ta;
        clock_gettime(CLOCK_MONOTONIC, &now_ta);
        float turn_around = ((double)now_ta.tv_sec + (double)now_ta.tv_nsec / 1000000000.0) - p->timestamp;
        if(turn_around < min_turn_around || min_turn_around <= 0.0) min_turn_around = turn_around;
        if(turn_around > max_turn_around || max_turn_around <= 0.0) max_turn_around = turn_around;
        total_turn_around += turn_around;

        // Print out product data
        printf("\e[92m[C] Consumer %d has consumed product: { id:%d, timestamp:%f, life:%d } (Products in queue: %d/%d) -- Turn-around: %fs\e[39m\n", consumer_id, p->id, p->timestamp, p->life, product_queue->size, product_queue->max_size, turn_around);

        free(p);
        products_consumed++;
      }
    } else if(scheduling_alg == ROUND_ROBIN) { // Implements the round-robin algorithm
      Product* p = dequeue(product_queue);
      if(p != NULL) {

        // Calculate and track wait time
        struct timespec now_wt;
        clock_gettime(CLOCK_MONOTONIC, &now_wt);
        double wait_time = ((double)now_wt.tv_sec + (double)now_wt.tv_nsec / 1000000000.0) - p->time_added;
        if(wait_time < min_wait_time || min_wait_time <= 0.0) min_wait_time = wait_time;
        if(wait_time > max_wait_time || max_wait_time <= 0.0) max_wait_time = wait_time;
        total_wait_time += wait_time;
        num_waits++;

        // Consume part or all of the product
        if(p->life >= quantum) {
          // If l>=q, then consume part of the product
          p->life = p->life - quantum;
          for(int i = 0; i < quantum; i++) {
            fib(10);
          }
          // Re-queue the product
          enqueue(product_queue, p);
        } else {
          // Completely consume the product
          for(int i = 0; i < p->life; i++) {
            fib(10);
          }

          // Calculate and track turn-around time
          struct timespec now_ta;
          clock_gettime(CLOCK_MONOTONIC, &now_ta);
          double turn_around = ((double)now_ta.tv_sec + (double)now_ta.tv_nsec / 1000000000.0) - p->timestamp;
          if(turn_around < min_turn_around || min_turn_around <= 0.0) min_turn_around = turn_around;
          if(turn_around > max_turn_around || max_turn_around <= 0.0) max_turn_around = turn_around;
          total_turn_around += turn_around;

          printf("\e[92m[C] Consumer %d has consumed product: { id:%d, timestamp:%f, life:%d } (Products in queue: %d/%d) -- Turn-around: %fs\e[39m\n", consumer_id, p->id, p->timestamp, p->life, product_queue->size, product_queue->max_size, turn_around);
          free(p);
          products_consumed++;
        }
      }
    } else {
      printf("Unknown scheduling algorithm.\n");
    }

    // Wake up the producers if they may have been sleeping
    if(product_queue->size == product_queue->max_size-1) {
      pthread_cond_broadcast(&producer_lock);
    }

    fflush(stdout);
    pthread_mutex_unlock(&product_mutex);
    usleep(100000);
  }

  printf("Consumer %d terminating...\n", consumer_id);

  // The last thread exiting will set the final value of the consumer end time
  struct timespec consumer_end;
  clock_gettime(CLOCK_MONOTONIC, &consumer_end);
  consumer_end_time = (double)consumer_end.tv_sec + ((double)consumer_end.tv_nsec / 1000000000.0);

  pthread_exit(NULL);
}

// Fibonacci function to simulate consumption of product
int fib(int num){
  if(num<=1)
    return num;
  else return fib(num-1) + fib(num-2);
}