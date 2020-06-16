/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_shell.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#include <stdlib.h>
#include "cs392_exec.h"
#include "cs392_log.h"
#include "cs392_signal.h"

#define BUFF 256
// I'm not sure if 256 is right but it seemed to be okay in my testing

int main(){

    char buffer[BUFF];
    int readIn;
    int i;
    
    while(1){
        handleSignal();
        printf("cs392_shell $: ");
        fflush(stdout); //The above print statement doesn't have a newline character so you need to flush it out
        
        // below read(0, ...) is equivalent to read(stdin,...)
        if( (readIn = read(0, buffer, BUFF-1)) < 0){
            if(errno == EINTR){     //received signal, ignore current read and continue
                continue;           //no printf statement needed because its handled in the signal file
            }else{
                perror("Error reading in.\n");
                exit(1);
            }
        }
        //printf("%d\n", readIn);
        buffer[readIn-1] = '\0';
        //printf("Received command: %s\n", buffer);
        writeToLog(buffer);     // I have it write to the log first in case its a command like 
        executeCommands(buffer);// exit which will quit the shell, if it were second it wouldnt log
    }
    return 0;
}