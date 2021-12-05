/* Example code showing use of 2D arrays and pointers in C. */

#include <stdlib.h>
#include <stdio.h>
#define ROWS 3
#define COLS 5

int main() {

    /* stack allocated 2D array */

    char stuff[2][3] = { {'a', 'b', 'c'}, {'d', 'e', 'f'} };

    for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 3; col++)
            printf("%c ", stuff[row][col]);  /* print a character */
        printf("\n");
    }
           
    /* allocate, in the heap, a ROWS-by-COLS array of integers */

    int* matrix = (int*) malloc( ROWS * COLS * sizeof(int) );

    /* initialize it using index notation
     * Note: we can't use [row][col] because the declaration of matrix
     * doesn't give the compiler a clue what are the dimensions. */ 
    for (int row = 0; row < ROWS; row++)
        for (int col = 0; col < COLS; col++)
            matrix[ row*COLS + col ] = row; /* assign the row number, as example */

    /* modify it, using pointer arithmetic */
    for (int row = 0; row < ROWS; row++)
        for (int col = 0; col < COLS; col++)
            *(matrix + (row*COLS) + col) += 1; /* add one */

    /* display the result */
    for (int row = 0; row < ROWS; row++) {
        for (int col = 0; col < COLS; col++)
            printf("%i", matrix[row*COLS + col]);
        printf("\n");
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* primer on pointers 
     * 
     * You've already seen examples of pointers to structs (e.g. basicstack.c)
     * allocated in the heap by malloc.  You've also seen character pointers
     * and array names as pointers.  The only other kind of pointers you
     * need in this course is taking the address of a stack variable for
     * use by a library function.  There are examples in graphioX.c and
     * here's a simple example.
     */
     int x;
     char* y = (char*) malloc(10);
     char* str = "farenheit 451";
     /* sscanf needs the address of a place to put a string and 
      * the address of a place to put an int. */
     sscanf(str, "%s %i", y, &x);
     
     printf("%s %i \n", y, x);

     /* Note: this is idiomatic, but there are security risks...
      * Anyway, this idiom is the only use you should make of the & operator
      * in this course. */

}
