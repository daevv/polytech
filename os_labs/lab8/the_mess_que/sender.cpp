/*
** sender.cpp -- writes to a message queue
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

struct my_msgbuf {
	long mtype;
	char mtext[200];
};

int main(void)
{
    long message_type = 1;
	struct my_msgbuf buf;
	int msqid;
	key_t key;

	if ((key = ftok(".", 'B')) == -1) {
		perror("ftok");
		exit(1);
	}

	if ((msqid = msgget(key, 0644 | IPC_CREAT)) == -1) {
		perror("msgget");
		exit(1);
	}
	
	printf("Enter lines of text, ^D to quit:\n");

	while(fgets(buf.mtext, sizeof buf.mtext, stdin) != NULL) {
        // if (message_type == 1) {
        //     message_type = 2;
        // } else {
        //     message_type = 1;
        // }
		int len = strlen(buf.mtext);

		/* ditch newline at end, if it exists */
		if (buf.mtext[len-1] == '\n') buf.mtext[len-1] = '\0';
		buf.mtype = 1;
		if (msgsnd(msqid, &buf, len+1, 0) == -1) /* +1 for '\0' */
			perror("msgsnd");
		buf.mtype = 2;
		if (msgsnd(msqid, &buf, len+1, 0) == -1) /* +1 for '\0' */
			perror("msgsnd");
	}

	if (msgctl(msqid, IPC_RMID, NULL) == -1) {
		perror("msgctl");
		exit(1);
	}

	return 0;
}

