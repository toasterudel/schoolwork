/*
* John Banya and Christopher Rudel
* "I pledge my honor that I have abided by the Stevens Honor System."
*/

#ifndef QUEUE_H
#define QUEUE_H

#include <unistd.h>
#include <stdlib.h>
#include <time.h>

typedef struct product_struct Product;
struct product_struct {
	int id; // product id
	double timestamp;
	int life;
	double time_added; // Time when added to the queue (used to calculate wait times). In FCFS, this is unnecessary, but matters for RR because we may re-add to queue multiple times.
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