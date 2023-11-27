/* The client program  pipe_client.cpp */
#include"p.h"
#include<signal.h>

int privatefifo, publicfifo;
struct message msg;

void handler(int sig) {
    if (sig == SIGINT) {
        close(privatefifo);
        close(publicfifo);
        unlink(msg.fifo_name);
    }
    exit(0);
}

int main(void) {
    signal(SIGINT, handler);
    int n;
    static char buffer[PIPE_BUF];
    /* Make the name for the private FIFO */
    sprintf(msg.fifo_name, "/tmp/fifo %d", getpid());
    /* Generate the private FIFO */
    if (mknod(msg.fifo_name, S_IFIFO | 0666, 0) < 0) {
        perror(msg.fifo_name);
        exit(1);
    }
    /* OPEN the public FIFO for writing */
    if ((publicfifo = open(PUBLIC, O_WRONLY | O_NONBLOCK)) == -1) {
        execlp("./pipe_server", "./pipe_server", NULL);
    }
    while (1) {    /* FOREVER */
        write(fileno(stdout), "\ncmd>", 6);
        memset(msg.cmd_line, 0x0, B_SIZ);    /* Clear first */
        n = read(fileno(stdin), msg.cmd_line, B_SIZ); /* Get cmd */
        if (!strncmp("quit", msg.cmd_line, n - 1))
            break;                /* EXIT? */
        write(publicfifo, (char *) &msg, sizeof(msg)); /* to PUBLIC */
        /* OPEN private FIFO to read returned command output */
        if ((privatefifo = open(msg.fifo_name, O_RDONLY)) == -1) {
            perror(msg.fifo_name);
            exit(3);
        }
        /* READ private FIFO and display on standard error */
        while ((n = read(privatefifo, buffer, PIPE_BUF)) > 0) {
            write(fileno(stderr), buffer, n);
        }
        close(privatefifo);
    }
    close(publicfifo);
    unlink(msg.fifo_name);
}
    
	



