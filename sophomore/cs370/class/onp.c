#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
void onp(char* str)
{
    int place = 0;
    int *stack = malloc(400*sizeof(int)); //Operator stack
    char *queue= malloc(400*sizeof(int)); //Output queue
    int stackP = 0;
    int queueP = 0;    
    while(str[place]!=0)
    {
        if(isalpha(str[place])){
            queue[queueP] = str[place];
            queueP++;
        }
        else{
            stack[stackP] = str[place];        
        }
        place++;
    }

    for(int i=0; i<=queueP; i++)
        printf("%d ", queue[i]);
    printf("\n");
    for(;stackP>=0; stackP--)
        printf("%c ", stack[stackP]);

    return;
}
int main()
{
    int num;
    char* exp;
    scanf("%d", &num);
    while(num >=1)
    {
        scanf("%s", exp);
        onp(exp);
    }
    return 0;
}


