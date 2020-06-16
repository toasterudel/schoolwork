#include <stdio.h>

union my_union {int i; char c; double d;};

int main()
{
    union my_union test;
    int var0;
    test.i = 0;
  //  test.c = 'A';
    test.d = 1.0;
    var0 = test.c;

    printf("%d\n", var0);
}