#include<stdio.h>

int cs392_sum(int, int); //this declares the cs392_sum function 

int main(int argc, char** argv){

	int a = 1;
	int b = 2;
	int c = cs392_sum(a, b);

	printf("The summation of a and b is %d\n", c);
	return 0; 
}

