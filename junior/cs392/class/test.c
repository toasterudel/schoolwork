#include <stdio.h>
#include <string.h>
int main(){

	char src[] = "hello";
	char dest[10];
	strcpy(dest,src);
	int i=0;
	while(dest[i] != '\0'){
		i++;
	}
	printf("%d\n",i);
	return 0;
}

