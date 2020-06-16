#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>

int main(){
    key_t KEY = ftok("./", 'A');
    int shmID = shmget(KEY, 2*sizeof(int), IPC_CREAT | 0666);
    void *buf = shmat(shmID, NULL, 0);
    int *array = (int*) buf;
    array[0] = 0;
    array[1] = 0;
    array[0] = 1;

    printf("Before loop array[1] = %d\n", array[1]);
    while(array[1] != 1){}
    printf("After loop: %d\n", array[1]);

    shmdt(buf);
    shmctl(shmID, IPC_RMID, NULL);
    return 0;
}