/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_strncat.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*   strncat takes the first n bytes of the src string and appends it on to the dest string
*   this function overwrites the '\0' on the dest string with the appending string
*   the assignment specified we don't have to worry about the size of the string
*   we also don't have to worry about dest or src being NULL
*/
#include "cs392_midterm.h"

char *cs392_strncat(char *dest, char *src, unsigned n){
    int destSize = 0, i=0;

    while(dest[destSize] != '\0'){
        destSize++;
    }
    for(; i<n && src[i] != '\0'; destSize++,i++){
        dest[destSize] = src[i];
    }
    dest[destSize] = '\0';

	return dest;
}
