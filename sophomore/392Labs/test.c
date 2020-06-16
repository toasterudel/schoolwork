#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
	int j = 1;
	char buffer[256];
	while(j)
	{
		for(int i=0; i<10; i++)
		{
			printf("%i\n", i);
			if(i ==5)
			{
				printf("Do we stop?");
				continue;
			}
		}
		bzero(buffer, 256);
		fgets(buffer, 255, stdin);
		j = atoi(buffer);
	}
}
