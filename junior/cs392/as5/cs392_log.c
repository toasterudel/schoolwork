/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_log.c
*   I pledge my honor that I have abided by the Stevens Honor System Christopher Rudel
*
*/

#include "cs392_log.h"

void cs392_socket_log(char* ipAddr, int portNum){
    FILE *fp = fopen("cs392_socket.log", "a");
    if(fp == NULL){
        perror("Error opening file.\n");
        exit(1);
    }else{
        fprintf(fp,"IP address: %s, port number: %d\n", ipAddr, portNum);
    }
    fclose(fp);
}