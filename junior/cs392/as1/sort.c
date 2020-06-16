/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   sort.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*   To compile: gcc -O0 cat.c -o sort
*/

#include "sort.h"

ulong arrLength;

uint* readIntoArray(char* filename){
    char* str;
    uint* arr;    //because this is an unsigned int we cannot take in negative numbers, goes up to 4294967295 inclusive
    size_t sz;
    FILE *fp = fopen(filename, "rb");
    if(fp == NULL){
        printf("Cannot open file due to error %d\n", errno);
        exit(EXIT_FAILURE);
    }
    fseek(fp, 0L, SEEK_END);
    sz = ftell(fp);  
    rewind(fp);
    str = malloc(sz+1);           
    arr = malloc(sz+1);
    if(str == NULL || arr == NULL){
      printf("Malloc failed due to %d, exiting...\n", errno);
      //freeing to prevent memory leak
      free(str);
      free(arr);    
      exit(EXIT_FAILURE);
    }
    
    for(size_t i=0; i<sz+1; i++){     
      str[i] = 0;              
    }
    
    size_t i = 0;
    while(fgets(str, sz, fp) != NULL){        
        if (ferror(fp)){       
            printf("Cannot read data due to %d\n", errno);
        }
        arr[i] = atoi(str);
        i++;
    }
    //printf("%ld\n", i);
    arrLength = i;
    free(str);
    fclose(fp);
    return arr;
}

/*
Below is the sorting i used originally but the max uint was too big for it


void heap(uint* arr, uint n, uint i){
  uint largest = i;
  uint l = 2*i + 1;
  uint r = 2*i + 2;
  printf("%u, %u, %u\n", largest, l,r);

  if(l<n && arr[l] > arr[largest]){
    largest = l;
  }

  if (r < n && arr[r] > arr[largest]){
    largest = r;
  }
  if(largest != i){
    //swap
    uint temp = arr[i];
    arr[i] = arr[largest];
    arr[largest] = temp;
    heap(arr, n, largest);
  }

}

void heapSort(uint* arr, int n){

    for(uint i=(int)n/2-1; i>=0; i--){
      heap(arr, n, i);
    }

    for(uint i=n-1; i>=0; i--){
      //swap 
      uint temp = arr[0];
      arr[0] = arr[i];
      arr[i] = temp;

      heap(arr, i, 0);
    }
}
*/

int compare( const void* first , const void* second )
{
    uint firstOne = *(uint*)first;
    uint secondOne = *(uint*)second;
    if( firstOne < secondOne ){
        return -1;
    }
    else if( firstOne > secondOne ){
        return 1;
    }
    else{
        return 0;
    }
}

void outputToFile(uint* nums, char* file){

  FILE *fp = fopen(file, "wb");
  if(fp == NULL){ // I don't think this should ever happen because the file does not need to exist for it to write
      printf("Cannot open file due to error %d\n", errno);
      exit(EXIT_FAILURE);
  }
  /*
  Below is how to output to a file in decimal:
  char str[20];
  for(int i=0; i<arrLength; i++){
	  snprintf(str, 10, "%d\n", nums[i]);
  	fputs(str, fp);
  }*/
  fwrite(nums, sizeof(uint), arrLength, fp);    //This is writing to the output file in the format of binary like the assignment specified
  fclose(fp);
}

int main(int argc, char** argv){
    if(argc != 3){
        printf("Please specify 2 arguments. Usage: ./sort <inputfile> <outputfile>\n");
        exit(EXIT_FAILURE);
    }
    arrLength = 0;
    uint *myNums = readIntoArray(argv[1]);            //argv[1] should be the input file
    //heapSort(myNums, arrLength); originally i used this but it wasnt working :(
    qsort(myNums, arrLength, sizeof(uint), compare);  //this is just straight up taken from the slides
    outputToFile(myNums, argv[2]);                    //argv[2] should be the output file
    free(myNums);                                     //cleanup
    return 0;
}
