#include <stdio.h>
#include <stdlib.h>
#include "SVdict.h"
#include <math.h>


int main()
{
	int t[2][3];
	t[0][0] = 1;
	t[1][0] = 2;
	t[0][1] = 3;
//	printf("%i %i %i\n" , t[0][0], t[1][0], t[0][1]);
	int *y = NULL;
 //   printf("%d\n", &y);
    char* x = "Hola\n";
   // printf(x);
//    printf("%s\n", x);



    int a = 5;
    int b = 6;

    printf("%i",bigger(b,a));


    int test[3] = {1,2,3};
    int i=0;
    while(test[i]!= 0)
    {
    	printf("success\n");
    	i++;
    }

    printf("%f, %i\n", INFINITY, INFINITY);
    float u = INFINITY;
    if(u!=0)
    	printf("int compare\n");
    if(u==INFINITY)
    	printf("infin compare\n");
}

int bigger(int a,int b)
{                                                     	
	return a>b;
}