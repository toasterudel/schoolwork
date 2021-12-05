/*
	stringMatch.c
	Christopher Rudel
	2/21/17
	Answers to the exercise are in the comments where the questions were originally asked
*/


#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

/* Exercise: 
- implement the function below, using loop(s) and a brute force algorithm.
- briefly discuss the time complexity of your implementation:
  + what is a good choice of basic operation to count
  A good choice of the basic operation to count would multiplication
  + what is a good measure of the input size
  I don't understand the question
  + do some inputs take more time than others?
  Obviously some inputs will take the machine more time than others because if the input 
  size is very long, it will take the machine longer to traverse through the entire input
  + if so, what inputs are worst case?
  Worst case inputs are ones that approach very large numbers
  + what is the (worst case) time complexity?
  Worst case time complexity would be O(strlen(text) * strlen(pattern))
*/


/* String match.

Assume text and pattern are null-terminated strings.
Return the index of the beginning position of the first
place in text where pattern matches exactly.  If pattern
does not match anywhere, return -1. 
For examples, see the asserts in main(), which should all succeed.

Hints: 
- Use array notation to access characters in the strings, 
  e.g., text[0] is the first character of the text (or possibly null
  if it's the empty string).
- To determine the range of possible indices, one option is to 
  use strlen() from the standard library.  It returns the length not 
  counting the \0 terminator.
  Another option is to check for null (in both text and pattern) as part
  of the matching process.
- You don't need to use the strcmp function or other library functions.
*/
int match(char* text, char* pattern) {
    int i, j, k;
    i = 0;
    j = 0;

    if(patlen == 0 || textlen == 0)
      return 0;


    while(text[i] != '\0')
  	{
	     while(text[i] != pattern[0] && text[i] != '\0')
	         i++;
	     if(text[i]=='\0')
	        return(-1);     //search can not continue


	     k=i;
	  
	     while(text[i]==pattern[j] && text[i]!='\0' && pattern[j]!='\0')
	     {
	     i++;
	     j++;
	     }

	    if(pattern[j]=='\0')
	       return(k);
	    if(text[i]=='\0')
	       return(-1);
	    i=k+1;
	    j=0;
  	}
  
}

int main() {
     assert(match("found", "found") == 0);
     assert(match("found", "lost") == -1);
     assert(match("found", "fount") == -1); 
     assert(match("unfound", "found") == 2);
     assert(match("found", "") == 0);
     assert(match("there is more to life than its speed", "Ghandi") == -1);
     assert(match("nobody noticed him", "not") == 7);
     assert(match("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "a" ) == 0);

    printf("tests successful\n");
}

