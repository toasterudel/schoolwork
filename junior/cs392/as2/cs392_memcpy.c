/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_memcpy.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#include "cs392_string.h"

void * cs392_memcpy ( void * dst, void * src, unsigned num){
    char *charSrc = (char*) src;    //typecasting the void pointers to something (char)
    char *charDst = (char*) dst;

    for(int i=0; i<num; i++){   //assign num amount of bytes from src to dst
        charDst[i] = charSrc[i];
    }
    return dst;
}
