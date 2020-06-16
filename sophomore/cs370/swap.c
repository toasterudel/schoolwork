#include <stdio.h>
#include <stdlib.h>

typedef struct node{
	int data;
	struct node* left;
	struct node* right;
}Node;


Node makeTree()
{
	Node* tree = malloc(sizeof(Node));
	tree->data = 1;
	tree->left = NULL;
	tree->right = NULL;
	return *tree;
}

void addLeft(Node *n, int l)
{
	Node *newNode = n->left;
	if(l!=-1)
	{
		newNode->data = l;
	}
}

void addRight(Node *n, int r)
{
	Node *newNode = n->right;
	if(r!=-1)
	{
		newNode->data = r;
	}
}

int main()
{
	int numTimes;
	scanf("%d\n", &numTimes);
	Node tree = makeTree();
	
}
