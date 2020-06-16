#include <stdio.h>
#include <stdlib.h>
int main(){
    char *ptr;
    int sz;
    FILE *fp = fopen("test.txt", "r");
    fseek(fp, 0L, SEEK_END);
    sz = ftell(fp);
    ptr = malloc(sz);
    fread(ptr, 1, sz, fp);
    printf("%s\n", ptr);
    free(ptr);
    fclose(fp);
    return 0;
}