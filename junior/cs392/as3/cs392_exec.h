/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_exec.h
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/
#ifndef CS392_EXEC_H
#define CS392_EXEC_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

char** separateWords(char*);
void executeCommands(char*);


#endif