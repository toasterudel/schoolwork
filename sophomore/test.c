#include <stdio.h>
#include <string.h>

int main()
{
	char* test[] = {"hello", "hi", "whats up"};
	int i=0;
	while(test[i] != '\0'){
		printf("%s\n", test[i]);
		i++;
}
}
