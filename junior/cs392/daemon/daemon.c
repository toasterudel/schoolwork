/*
*   Christopher Rudel
*   Professor Jun
*   Daemon Quiz
*   I pledge my honor that I have abided by the Stevens Honor System
*/


#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <syslog.h>
#include <string.h>
#include <time.h>

int main(){
    pid_t pid, sid;

    pid = fork();
    if(pid < 0){
        perror("error forking\n");
        exit(EXIT_FAILURE);
    }
    if(pid > 0){
        exit(EXIT_SUCCESS);
    }

    umask(0);
    sid = setsid();
    if(sid < 0){
        perror("error with setsid\n");
        exit(EXIT_FAILURE);
    }
    if(chdir("/tmp") < 0){
        perror("error change directory\n");
        exit(EXIT_FAILURE);
    }

    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    FILE *fp = fopen("cs392_daemon.log", "a");
    if(fp == NULL){
        perror("cannot open file\n");
        exit(EXIT_FAILURE);
    }
    time_t t;
    struct tm *tm;
    while(1){
        sleep(2);
        t = time(NULL);
        tm = localtime(&t);
        fprintf(fp, "%s", asctime(tm));
        fflush(fp);
    }
    fclose(fp);
    return 0;
}