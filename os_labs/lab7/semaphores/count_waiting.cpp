#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

#define MAX_RETRIES 10

union semun {
    int val;
    struct semid_ds* buf;
    ushort* array;
};

int main() {
    char u_char = 'J';
    key_t key;
    int semid;

    if ((key = ftok(".", u_char)) == -1) {
        perror("ftok");
        exit(1);
    }
    semid = semget(key, 1, IPC_EXCL | 0666);
    fprintf(stderr, "semaphore id: %d\n", semid);
    int prcCnt = semctl(semid, 0, GETNCNT);
    fprintf(stderr, "processes waiting: %d\n", prcCnt);
}
