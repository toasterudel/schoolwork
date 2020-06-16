/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_thread.c
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

#define gettid() syscall(SYS_gettid)

int item1_counter = 0, item2_counter = 0, item3_counter = 0;
pthread_t thread1, thread2, thread3;
pthread_mutex_t lock1, lock2, lock3;


void *cs392_thread_run(void* arg){
    FILE *fp = fopen((char*)arg, "r");
    if(fp == NULL){
        printf("Cannot open file due to error %d\n", errno);
        exit(EXIT_FAILURE);
    }
    char buffer[256];
    while( fgets(buffer, sizeof(buffer), fp) != NULL){
        if(buffer[5] == '1'){
            pthread_mutex_lock(&lock1);
            if(buffer[0] == '+'){
                item1_counter += 1;
            }
            else if(buffer[0] == '-'){
                item1_counter -= 1;
            }

            pthread_mutex_unlock(&lock1);
        }
        else if(buffer[5] == '2'){
            pthread_mutex_lock(&lock2);
            if(buffer[0] == '+'){
                item2_counter += 1;
            }
            else if(buffer[0] == '-'){
                item2_counter -= 1;
            }

            pthread_mutex_unlock(&lock2);

        }
        else if(buffer[5] == '3'){
            pthread_mutex_lock(&lock3);

            if(buffer[0] == '+'){
                item3_counter += 1;
            }
            else if(buffer[0] == '-'){
                item3_counter -= 1;
            }

            pthread_mutex_unlock(&lock3);
        }
    }
    fclose(fp);

    return NULL;

}


int main(int argc, char** argv){
    if(argc != 4){
        perror("Incorrect number of arguments: Expected 3.\nUsage: ./cs392_thread ./item_file1.txt ./item_file2.txt ./item_file3.txt\n");
        exit(EXIT_FAILURE);
    }

    //initializing mutexes
    if( pthread_mutex_init(&lock1, NULL) != 0){
        perror("Cannot create mutex 1, exiting...\n");
        exit(EXIT_FAILURE);
    }
    if( pthread_mutex_init(&lock2, NULL) != 0){
        perror("Cannot create mutex 2, exiting...\n");
        exit(EXIT_FAILURE);
    }
    if( pthread_mutex_init(&lock3, NULL) != 0){
        perror("Cannot create mutex 3, exiting...\n");
        exit(EXIT_FAILURE);
    }

    //initializing threads
    if( pthread_create(&thread1, NULL, cs392_thread_run, argv[1]) != 0){
        perror("Cannot create thread 1, exiting...\n");
        exit(EXIT_FAILURE);
    }
    if( pthread_create(&thread2, NULL, cs392_thread_run, argv[2]) != 0){
        perror("Cannot create thread 2, exiting...\n");
        exit(EXIT_FAILURE);
    }
    if( pthread_create(&thread3, NULL, cs392_thread_run, argv[3]) != 0){
        perror("Cannot create thread 3, exiting...\n");
        exit(EXIT_FAILURE);
    }

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);

    pthread_mutex_destroy(&lock1);
    pthread_mutex_destroy(&lock2);
    pthread_mutex_destroy(&lock3);

    printf("Final scores, 1:%d, 2:%d, 3:%d\n", item1_counter, item2_counter, item3_counter);

    pthread_exit(NULL);
    return 0;
}