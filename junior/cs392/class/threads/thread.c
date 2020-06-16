#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>

#define gettid() syscall(SYS_gettid)

int counter = 0;

void* run_thread(void* noarg){
    int i=0;
    for(; i<100000; i++){
        counter++;
    }
    pthread_exit(NULL);
    return NULL;
}


int main(){
    pthread_t thread1, thread2;
    //printf("%d\n", counter);
    pthread_create(&thread1, NULL, run_thread, NULL);
    pthread_create(&thread2, NULL, run_thread, NULL);
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    printf("%d\n", counter);

    pthread_exit(NULL);
    printf("Hello\n");

    return 0;
}
