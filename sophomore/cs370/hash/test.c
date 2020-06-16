#include <stdio.h>

int main(void) {
	int num;
	while(1)
	{
		scanf("%d", &num);
		if(num == 42)
			break;
		else printf("%d\n", num);
	}

	return 0;
}
