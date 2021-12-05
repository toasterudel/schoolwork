/*
test.c
2/5/17
CS182 
Christopher Rudel
I pledge my honor that I have abided by the Stevens Honor System
*/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "SIdict.h"
#include "SIdictBST.c"


int main(void)
{
	SIdict dict0, dict1;
	dict0 = makeSIdict();
	hasKey(dict0, "apple");
	addOrUpdate(dict0, "apple" , 1);
	hasKey(dict0, "apple");
	addOrUpdate(dict0, "banana" , 2);
	remKey(dict0, "apple");
	hasKey(dict0, "apple");
	printf("Banana value: %d\n" , lookup(dict0, "banana"));

	dict1 = makeSIdict();
	addOrUpdate(dict1, "artichoke" , 1);
	addOrUpdate(dict1, "boat" , 2);
	addOrUpdate(dict1, "circus" , 3);
	remKey(dict1, "boat");
	printf("Circus value: %d\n" , lookup(dict1, "circus"));
}