#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

struct link{
	void* elem;
	struct link* next;
};

void* my_malloc(int size)
{
	void* block;
	block = sbrk(size);
	if(block == (void*) -1)
		return NULL;
	return block;
}

int main()
{
	int* myMall = (int*) my_malloc(sizeof(int));
	*myMall = 3;
	printf("%d\n", *myMall);
	
}
