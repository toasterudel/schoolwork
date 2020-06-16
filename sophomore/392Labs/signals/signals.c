/* A C program that does not terminate when Ctrl+C is pressed */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
 
/* Signal Handler for SIGINT */
void sigintHandler(int sig_num)
{
    signal(SIGINT, sigintHandler);
    printf("\n Cannot be terminated using Ctrl+C \n");
    fflush(stdout);
}

/* Signal Handler for SIGSTOP
void sigstopHandler(int sig_num)
{
	signal(SIGSTOP, sigintHandler);
	
}*/
 
int main ()
{
    int blah = fork();

    signal(SIGINT, sigintHandler);
 	//signal(SIGSTOP, sigstopHandler);
	
    /* Infinite loop */
    while(1)
    {
		pause();        
    }
    return 0;
}
