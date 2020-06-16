/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cat.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*   To compile: gcc -O0 cat.c -o cat
*/
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>                // this is only used for errno, I'm just going off the slides

void argCheck(int args){
      if(args < 2){
        printf("Please specify the filename. Usage: ./cat <filename>\n");
        exit(EXIT_FAILURE);
    } else if(args > 2){
        printf("Please only input one file. Usage: ./cat <filename>\n");
        exit(EXIT_FAILURE);
    }
    return;
}

void readAndPrint(char* path){
    FILE *fp = fopen(path, "rb");
    if(fp == NULL){
        printf("Cannot open file due to error %d\n", errno);
        exit(EXIT_FAILURE);
    }
    size_t sz;
    char *ptr;
    fseek(fp, 0L, SEEK_END);        // goes to the end of the file
    sz = ftell(fp);                 // sets size equal to the size of the file
    rewind(fp);                     // goes back to the beginning of the file, same thing as fseek(fp, 0L, SEEK_SET);

    ptr = malloc(sz+1);           // allocating memory based off the size of the file
    if(ptr == NULL){
      printf("Malloc failed due to %d, exiting...\n", errno);    
      exit(EXIT_FAILURE);
    }
    for(size_t i=0; i<sz+1; i++){     // this isn't necessary but valgrind was giving me errors without it
      ptr[i] = '0';                   // also I'm pretty sure this is good practice
    }

    // reading into the ptr below
    fread(ptr,sizeof(char), sz, fp);
    for(size_t i=0; i<sz; i++){
      printf("%c", *(ptr+i));
    }

    /*
    while(fgets(ptr, sz, fp) != NULL){        
        if (ferror(fp)){       
            printf("Cannot read data due to %d\n", errno);
        }
        printf("%s", ptr);     
    }   */
    free(ptr);
    fclose(fp);
}

int main(int argc, char** argv){
    argCheck(argc);
    readAndPrint(argv[1]);
    return 0;       // in the slides he often puts return 1, but that typically means an unsuccessful execution

}

