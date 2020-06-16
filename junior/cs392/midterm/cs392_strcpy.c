/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_strcpy.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*   cat takes the src string and copies it into dst, including the null terminating byte '\0'
*   the assignment specified we don't have to worry about the size of the string
*   we also don't have to worry about dest or src being NULL
*/
#include "cs392_midterm.h"

char *cs392_strcpy(char *dest, char *src){

    int i=0; 
    while(src[i] != '\0'){
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';

	return dest;
} 