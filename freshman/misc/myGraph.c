/*
	graph.c
	Christopher Rudel
	I pledge my honor that I have abided by the Stevens Honor System
	This file doesn't run it has too many errors but I have to turn in something
	I didn't get to do the exercises because I put in way too much time
	trying to finish this code
	Sorry
*/

#include <string.h>
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>

#include "graph.h"



struct matrixR{
	float ** q;
};

typedef struct matrixR Matrix;

struct listR{
	struct listR *next;
	float weight;
	int target;
};

struct listNode{
	struct listR** n;
};

typedef struct listNode* List;

struct graph{
	Matrix M;
	List L;
	int vertices;
	int r;
};

typedef struct graph* Graph;



/* Make an empty graph with n vertices, using either adjacency matrix 
   or adjacency lists depending on whether rep==MATRIX or rep==LIST.
   Precondition: n>=1 and rep is MATRIX or LIST.

   Time complexity: 
   (Didn't have time to do this)
*/
Graph makeGraph(int n, int rep)
{
	Graph gh = (Graph *) malloc(n * sizeof(Graph));
	gh-> vertices = n;
	gh-> r=rep;

	if(rep == 0 ) //Matrix
	{
		Matrix *m = (Matrix*) malloc(sizeof(Matrix));
		*m->q = (float**) malloc(n* sizeof(float**));

		for(int i=0; i<n; i++)
		 	*m-> q[i] = (float*) malloc(n* sizeof(float));
		
		for(int i=0; i<n; i++)
		{
			for(int j=0; j<n; j++)
			m->q[i][j] = INFINITY; 
		} 	
		gh->M = *m;
	}

	else if(rep == 1) //List
	{
		List l = (List ) malloc(sizeof(struct listNode));
		l->n = (struct listR **) malloc(n * sizeof(struct listR*) );
		for(int i = 0; i<n; i++)
			l->n[i] = NULL;

		gh->L = l;
	}
	return gh;

}


/* make a copy of g, but using the representation
   specified by rep (which is assumed to be MATRIX or LIST) 

   Time complexity: 
   (Didn't have time to do this)
*/
Graph cloneGraph(Graph G, int rep)
{
	Graph gh = (Graph ) malloc(sizeof(G));
	gh = G;
	gh -> r = rep;
	return gh;
}


/* free the graph object and all its resources.
   Postcondition: g is no longer a valid pointer. 

   Time complexity: 
   (Didn't have time to do this)
*/
void disposeGraph(Graph G)
{
	if(G->r == 0) //If its a Matrix
	{
		for(int i = 0; i < G->vertices; i++)
		{
			free(G->M.q[i]);
		}
	}

	free(G);
}

/* number of vertices */
int numVerts(Graph G)
{return G->vertices;}


/* add edge from source to target with weight w, and return
   OK, if source and target are valid vertex numbers and
   there was no edge from source to target initially.
   Otherwise, make no change and return ERROR. 

   Time complexity: 
   (Didn't have time to do this)
*/
int addEdge(Graph G, int source, int target, float w)
{
	if(G->r == 0) //If Matrix
	{
		if(G->M.q[source][target] == INFINITY)
		{
			G->M.q[source][target] = w;
			return OK;
		}
		else
			return ERROR;
	}
	else if(G->r == 1) //List
	{
		List *current = (List*) malloc(sizeof(List));
		List *nextNode = (List*) malloc(sizeof(List));
		*current = G->L;
		while(current!= NULL)
		{
			*current = *nextNode;
			*current = *current.*next; 
		}
		*current.target = target;
		*current.weight = w;
		return OK;
	}
	else return ERROR;
}


/* delete edge from source to target, and return
   OK, if there was an edge from source.
   Otherwise, make no change and return ERROR. 

   Time complexity: 
   (Didn't have time to do this)
*/
int delEdge(Graph G, int source, int target)
{
	if(G->r == 0) //Matrix
	{
		if(G->M.q[source][target] != INFINITY)
		{
			G->M.q[source][target] = INFINITY;
			return OK;
		}
		else return ERROR;
	}
	else if(G->r == 1) //list
	{
		if(G->L->n[source] != NULL)
		{

			return OK;
		}
		else return ERROR;
	}
	else 
		return ERROR;
}


/* return weight of the edge from source to target,
   if there is one; otherwise return INFINITY.
   Return -1.0 if source or target are out of range.

   Time complexity: 
   (Didn't have time to do this)
*/
float edge(Graph G, int source, int target)
{
	if(G->r == 0)
	{
		if(G->M.q[source][target] != INFINITY)
			return G->M.q[source][target];
		else return INFINITY;
	}
	else if(G->r == 1)
	{
		return G->vertices;
	}
	else return -1.0;
}


/* a freshly allocated array with the successor
   vertices of source, if any, followed by an entry with -1
   to indicate end of sequence.
   Precondition: source is in range.
   Ownersip: the caller is responsible for freeing the array.

   Time complexity: 
   (Didn't have time to do this)
*/
int* successors(Graph G, int source)
{
	//G->L->n->next
	int num = 0;
	while(G->L->n.next != NULL)
	{
		num++;
		G->L->n = G->L->n.next;
	}
	int *verts[num+1]; //+1 for end of sequence

	int i = 0;
	while(G->L->n.next != NULL)
	{
		i++;
		*verts[i] = G->vertices;
		G->L->n = G->L->n.next;
	}
	*verts[num] = -1; //end of sequence 

	return *verts;
}


/* a freshly allocated array with the predecessor
   vertices of target, if any, followed by an entry with -1
   to indicate end of sequence.
   Precondition: target is in range.
   Ownersip: the caller is responsible for freeing the array.

   Time complexity: 
   (Didn't have time to do this)
*/
int* predecessors(Graph G, int target)
{
	//Oh no I didn't define a previous for the nodes. Guess I'm taking the L
	
	int *prev[1];
	*prev[0] = -1;
	return *prev;	
}