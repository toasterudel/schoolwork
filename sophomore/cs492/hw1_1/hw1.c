#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
int main(int argc, char** argv)
{
    if(argc < 7)
    {
	printf("Please input the correct amount of parameters\n");
	return 0;
    }
    int prodThreads = atoi(argv[1]);
    int consThreads = atoi(argv[2]);
    int totProducts = atoi(argv[3]);
    int qSize = atoi(argv[4]); /* 0 means unlimited queue size */
    int typeAlgo = atoi(argv[5]); /* 0 is First come first server, 1 is Round robin */
    
    return 0;
}
