#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int substrings(char* balls)
{
		
}

int main()
{
	char* balls = (char*) malloc(512000 * sizeof(char));
	scanf("%s", balls);
	int result = substrings(balls);
	printf("%d\n", result);
	return 0;
}
