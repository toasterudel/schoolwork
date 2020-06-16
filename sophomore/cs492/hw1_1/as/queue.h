#ifndef QUEUE_H
#define QUEUE_H

#include <unistd.h>
#include <stdlib.h>

typedef struct product_struct Product;
struct product_struct {
	int id; // product id
	int timestamp; // in seconds since epoch
	int life;
};

typedef struct queue_node Node;
struct queue_node {
	Product* item;
	Node* next;
};

typedef struct queue_struct Queue;
struct queue_struct {
	Node* root;
	int size;
	int max_size;
};

Queue* create_queue(int);
void enqueue(Queue*, Product*);
Product* dequeue(Queue*);
Product* get_next_queued(Queue*);

#endif