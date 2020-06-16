#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>



int main(){

    uid_t cur_uid = getuid();
    printf("current userid is: %u\n", cur_uid);
    if(getuid() == 0){
        printf("we in here\n");
        if(setgid(0) != 0){
            perror("setgid: Unable to drop group privileges\n");
        }
        if(setuid(0) != 0){
            perror("setuid: Unable to drop user privileges");
        }
        printf("current userid is: %u\n", cur_uid);

    }
    else{
        printf("we not in here\n");
        printf("current userid is: %u\n", cur_uid);

    }
    return 0;
}