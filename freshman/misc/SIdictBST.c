/*
SldictBST.c
2/17/17
CS182 
Christopher Rudel
I pledge my honor that I have abided by the Stevens Honor System
NOTE; I will come in for office hours, I oculnd't this week though becasue I was away for 
the Swim Team Championships that is happening from Tuesday - Sunday. I really need 
help understanding C.
*/


#include <stdio.h>
#include <stdlib.h>
#include "SIdict.h"

struct si_dict {
	char key;
	int val;
	int deleted;  //1 if deleted, 0 if not deleted
	struct si_dict *left;
	struct si_dict *right;
};


/* make an empty one */
SIdict makeSIdict()
{
	SIdict dict = (SIdict) malloc(sizeof(struct si_dict));
	if(dict == NULL)
	{
		printf("ERROR, memory was not allocated.\n");
		exit(0);
	}
	dict->key = NULL;
	dict-> val = NULL;
	dict-> left = NULL;
	dict-> right = NULL;

	dict->deleted = 0;
	return dict;

}

/* whether key is present 
   Precondition: d and key are non-null. */
int hasKey(SIdict d, char* key)
{
	if(d->key == key)
		return 1;
	else return 0; 
}

/* map key to val; return 1 if key was already present else 0 
   Precondition: d and key are non-null. */
int addOrUpdate(SIdict d, char* key, int val)
{
	if(d->key != NULL)
	{
		d->key =  key;
		d->val =  val;
		return 1;
	}
	else{
		d = makeSIdict();
		d->key = key;
		d->val = val;
		
		//Here is where I would implement d->left and d->right if I knew how to.
	}
}

/* get value associated with key
   Precondition: d is non-null and key is present (so it's non-null). */
int lookup(SIdict d, char* key)
{
	if(d->deleted == 1)
	return -1;
	else{
		return d->val;
	}
}

/* Remove key/val; return 1 if key was already present else 0
   Precondition: d and key are non-null. */
int remKey(SIdict d, char* key)
{
	if(d->key == key)
	{
		d->deleted = 1;
/*This is trying to connect the nodes that the removed key was attached to
		d->left -> right = d->right;
		d->right -> left = d->left;	     									*/
		return 1;
	}
	else 
		return 0;
}