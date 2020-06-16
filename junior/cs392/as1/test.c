#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv){
    FILE* fp = fopen(argv[1],"rb");

    while(1){
    if(ferror(fp)){
        printf("Cannot read data\n");
      }
      unsigned int i = 0;
      fread(&i, sizeof(unsigned int), 1, fp);
      if(feof(fp)){
        break;
      }
      printf("%u\n",i);
    }

}