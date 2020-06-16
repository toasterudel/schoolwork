/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_strlen.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#include "cs392_string.h"

unsigned cs392_strlen(char *str){
    unsigned len = 0;
    for(int i=0; str[i] != '\0'; i++){
        ++len;  //the end of strings are terminated by \0
    }
    //probably could have just returned i but whatever
    return len;
}