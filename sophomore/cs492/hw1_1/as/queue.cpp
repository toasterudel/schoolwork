#include "queue.h"

/*
*	Implements a queue via a linked list.
*	Note that this implementation alone is not thread safe, but relies on the thread-safety of the functions that use it.
*/

// Creates a new queue
Queue* create_queue(int size) {
    Queue* q = (Queue*) malloc(sizeof(Queue));
    q->root = NULL;
    q->max_size = size;
    q->size = 0;  
    return q;
}

// Adds item to the back of the queue
void enqueue(Queue* q, Product* item) {
	Node* newNode = (Node*) malloc(sizeof(Node));
	newNode->item = item;
	newNode->next = NULL;

    // Add item
    q->size++;
	if(q->root != NULL) {
		// Case when queue is not empty
		Node* node = q->root;
		while(node->next != NULL)
			node = node->next;
		node->next = newNode;
	} else {
		// Queue is empty
		q->root = newNode;
	}
}

// Removes and returns the next item from the front of the queue
Product* dequeue(Queue* q) {
	Product* item = NULL;

	Node* node = q->root;
	if(node != NULL) {
		// Queue is not empty
		item = node->item;
		q->root = node->next;
		free(node);
    	q->size--;
	}

	return item;
}

// Gets the next item in the queue without removing it.
Product* get_next_queued(Queue* q) {
	Product* item = NULL;
	if(q->root != NULL) {
		item = q->root->item;
	}
	return item;
}