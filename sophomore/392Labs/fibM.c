#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
	char *args[] = {"./fib", argv[0], NULL};
	execvp(args[0], args);
	return 0;
}
