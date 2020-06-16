#include <stdio.h>

int main()
{
    //Star (*) is dereference 
    /*
    int a, b, c, *p;
    a = 1;
    p = &a;
    printf("a: %d, p: %d\n", a, *p);
    a = 2;
    printf("a: %d, p: %d\n", a, *p);
    *p = 4;
    printf("a: %d, p: %d\n", a, *p);
    */

   int a[10], *pa, b;
   for(int i=0; i<10; i++)
   {
       a[i] = i*10;
   }
   pa = &a[3];
   b = *(pa + 5);
   printf("pa: %d, b: %d\n", *pa, b);
}