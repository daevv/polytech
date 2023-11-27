// #include <stdio.h>
// #include <unistd.h>
// #include <sys/types.h>
// #include <stdlib.h>
// #include <sys/ipc.h>
// #include <sys/shm.h>

// int main(void) {
//     key_t key = 15;
//     char *shm_1, *shm_2, *shm_3;
//     int shmid_1, shmid_2, shmid_3;

//     // Создание трех сегментов разделяемой памяти
//     if ((shmid_1 = shmget(key, 1023, 0644 | IPC_CREAT)) == -1) {
//         perror("shmget shmid_1");
//         exit(1);
//     }

//     if ((shmid_2 = shmget(key + 1, 1023, 0644 | IPC_CREAT)) == -1) {
//         perror("shmget shmid_2");
//         exit(1);
//     }

//     if ((shmid_3 = shmget(key + 2, 1023, 0644 | IPC_CREAT)) == -1) {
//         perror("shmget shmid_3");
//         exit(1);
//     }

//     printf("Addresses in parent\n\n");

//     // Привязка сегментов с параметром shmaddr = 0
//     shm_1 = (char *)shmat(shmid_1, 0, 0);
//     if (shm_1 == (char *)(-1)) {
//         perror("shmat shm_1");
//         exit(1);
//     }
//     printf("Shared mem 1: %p\n", shm_1);

//     shm_2 = (char *)shmat(shmid_2, 0, 0);
//     if (shm_2 == (char *)(-1)) {
//         perror("shmat shm_2");
//         exit(1);
//     }
//     printf("Shared mem 2: %p\n", shm_2);

//     shm_3 = (char *)shmat(shmid_3, 0, 0);
//     if (shm_3 == (char *)(-1)) {
//         perror("shmat shm_3");
//         exit(1);
//     }
//     printf("Shared mem 3: %p\n", shm_3);

//     // Отсоединение сегментов (это может быть выполнено позже в программе)
//     shmdt(shm_1);
//     shmdt(shm_2);
//     shmdt(shm_3);

//     return 0;
// }

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#define SHM_SIZE 1023

extern int etext, edata, end;

main(void) 
{
	int shmid[3];
	char *data1, *data2, *data3;
	
	printf("Addresses in parent\n");
	printf("program text(etext): \t\t%10p\ninitialized data (edata):\t%10p\nuninitialized data (end): \t%10p\n", &etext, &edata, &end);
	for (int i = 0; i < 3; i++)
	{
		if ((shmid[i] = shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT|0666)) < 0)
		{
			perror("shmget fail");
			exit(1);
		}
		switch (i)
		{
			case 0:
				data1 = (char*) shmat(shmid[i], 0, 0);
				printf("shared mem %d: \t\t\t%10p\n", i, data1);
				break;
			case 1:
				data2 = (char*) shmat(shmid[i], 0, 0);
				printf("shared mem %d: \t\t\t%10p\n", i, data2);
				break;
			case 2:
				data3 = (char*) shmat(shmid[i], 0, 0);
				printf("shared mem %d: \t\t\t%10p\n", i, data3);
				break;
		}
	}
	for (int i = 0; i < 1023; i++) 
	{
		data1[i] = '1';
		data2[i] = '2';
		data3[i] = '3';
	}
	data1[1023] = 'I';
	data1[1024] = 'N';
	data1[1025] = 'F';
	printf("1: %s\n", data1);
	printf("2: %s\n", data2);
	printf("3: %s\n", data3);
} 	
