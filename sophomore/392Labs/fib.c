#include <stdio.h>
#include <unistd.h>

int fib(int num)
{
	if(num == 0)
		return 0;
	if(num == 1)
		return 1;

	int x = 0;
	int y = 1;
	int placeholder;
	for(int start = 1; start < num; start++)
	{
		placeholder = y;
		y += x;
		x = placeholder;
	}
	return y;
	
}


int main(char *args[], int count)
{
	int ret = fib((int)args[1]);
	printf("%i\n", ret);
}
