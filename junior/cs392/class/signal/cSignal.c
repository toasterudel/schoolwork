/*
*   Christopher Rudel
*   Professor Jun
*   CS392
*   Signal quiz
*   I pledge my honor that I have abided by the Stevens Honor System
*/
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>

int count = 0;

static void hdl(int sig, siginfo_t *siginfo, void* context){
    printf ("Sending PID: %ld, UID: %ld, thanks for reading\n",
		(long)siginfo->si_pid, (long)siginfo->si_uid);
}

int main(){
    struct sigaction act;
    memset(&act, '\0', sizeof(act));

    act.sa_sigaction = &hdl;
    act.sa_flags = SA_SIGINFO | SA_RESETHAND;

    if(sigaction(SIGINT, &act, NULL) < 0){
        perror("sigaction");
        return 1;
    }
    while(1){
        sleep(1);
        printf("Hellow\n");
    }

    return 0;
}