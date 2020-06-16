/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_strcmp.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*	strcmp takes two strings and returns 0 if the strings are equal,
*	positive if s1 > s2 and negative if s1 < s2 by comparing their ascii values
*	the assignment specified we don't have to worry about the size of the string
*   we also don't have to worry about dest or src being NULL
*/
#include "cs392_midterm.h"

int cs392_strcmp(char *s1, char *s2){
	int i=0;
	while(s1[i] != '\0' && s2[i] != '\0'){
		if(s1[i] == s2[i]){
			i++;
			continue;
		}
		else{
			return s1[i] - s2[i];
		}
	} 
    if(s1[i] == '\0' && s2[i] == '\0'){
	    return 0;
    }
    else if(s1[i] == '\0'){
        return -1;
    }
    else if(s2[i] == '\0'){
        return 1;
    }
    else{
        return 0;
    }
}
