#include <stdio.h>
#include <unistd.h>

int main()
{

	int x,y;
	x = fork();
	y = fork();

	if(x!=0) printf("Type1\n");
	if(y!=0) printf("Type2\n");

	if(x>0 || y>0) printf("Type3\n");
	if(x==0 && y==0) printf("Type4\n");
	if(x!=0 && y!=0) printf("Type5\n");
}
