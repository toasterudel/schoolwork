/*
SldictLL.c
2/5/17
CS182 
Christopher Rudel
I pledge my honor that I have abided by the Stevens Honor System
*/


#include <stdlib.h>
#include <stdio.h>     
#include <assert.h>
#include <string.h>

#include "Sldict.h"

struct si_dict{
	char key;
	int val;
}

/*Makes an empty one*/
SIdict makeSIdict()
{
	SIdict dict = (SIdict) malloc(sizeof(struct si_dict));
	dict->key = "";
	dict->val = NULL;
	

	return dict;
}

/*Tests if a key is present*/
int hasKey(SIdict d, char* key)
{
	if(strcmp(d->key , "") == 0)
		return 0;
	else return 1;
}

/* map key to val; return 1 if key was already present else 0 
   Precondition: d and key are non-null. */
int addOrUpdate(SIdict d, char* key, int val)
{
	if(hasKey(d, key) == 1)
		return 1;
	else
	{
		d->key = key;
		d->val = val;
		return 0;
	}
}

/* get value associated with key
   Precondition: d is non-null and key is present (so it's non-null). */
int lookup(SIdict d, char* key)
{
	if(hasKey(d, key) == 1)
	return d->value;
}

/* Remove key/val; return 1 if key was already present else 0
   Precondition: d and key are non-null. */
int remKey(SIdict d, char* key)
{
	if(hasKey(d, key) == 1)
	d->key= "";
	d->value = NULL;
}



