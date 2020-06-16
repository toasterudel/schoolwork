#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>


int main(){
    key_t SHMkey = ftok("./", 'A');
    int ShmId = shmget(SHMkey, 2*sizeof(int), IPC_CREAT | 0666);
    
    void *buff = shmat(ShmId, NULL,0);
    int *array = (int*) buff;
    while(array[0] !=1){
    }

    array[1] = 1;
    shmdt(buff);

    return 0;

}