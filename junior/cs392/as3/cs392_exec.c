/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_exec.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#include "cs392_exec.h"

int numWords;


// This function separates the commands into their own strings
char** separateWords(char* str){
    numWords = 1;
    for(int i=0; str[i] != '\0'; i++){
        if(str[i] == ' '){
            ++numWords;
        }
    }
    char** arr = malloc(256 * sizeof(char*));
    for(int i=0; i<numWords; i++){
        arr[i] = malloc(sizeof(char) * numWords);
    }
    char* word = strtok(str, " ");
    int place = 0;
    while(word != NULL){
        strcpy(arr[place], word);
        word = strtok(NULL, " ");
        place++;
    }
    arr[place] = NULL;
    
    return arr;
}

void executeCommands(char* str){

    char** words = separateWords(str);
    int pid;

    if( strcmp(words[0], "exit") == 0){
        printf("Exiting shell.\n");
        for(int i=0; i<numWords; i++){
            free(words[i]);
        }
        free(words);
        exit(0);
    }else{
        if ((pid = fork()) < 0){
            printf("Error forking, exiting...\n");
            for(int i=0; i<numWords; i++){
                free(words[i]);
            }
            free(words);
            exit(1);
        } else if(pid > 0){
            //This is the parent process
            wait(NULL);
        }else{
            //This is the child process, pid should = 0
            int work;
            if((work = execvp(words[0], words)) < 0){
                printf("%s: command not found.\n", words[0]);
                for(int i=0; i<numWords; i++){
                    free(words[i]);
                }
                free(words);
                exit(1);
            }
        }
    }
    for(int i=0; i<numWords; i++){
        free(words[i]);
    }
    free(words);        //valgrind says i have no memory leaks but some errors with strcmp and strcpy
}

