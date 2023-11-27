/* Программа  pipe_server.cpp */
#include"p.h"
#include <sys/wait.h>

int main(void) {
    int n, done, dummyfifo, privatefifo, publicfifo;
    static char buffer[PIPE_BUF];
    FILE *fin;
    struct message msg;
    /* Созданиеочередитипа public FIFO */
    mknod(PUBLIC, S_IFIFO | 0666, 0);
    /* Открыть public FIFO начтениеизапись */
    if (((publicfifo = open(PUBLIC, O_RDONLY)) == -1) || (dummyfifo = open(PUBLIC, O_WRONLY | O_NDELAY)) == -1) {
        perror(PUBLIC);
        exit(1);
    }
    /* Сообщение можно прочитать из public конвейера */
    while (read(publicfifo, (char *) &msg, sizeof(msg)) > 0) {
        int pid;
        if ((pid = fork() == 0)) {
            printf("pid: %i", getpid());
            n = done = 0; /* Очистка счетчиков | флагов */
            do {/* Попыткаоткрытия private FIFO */
                if ((privatefifo = open(msg.fifo_name, O_WRONLY | O_NDELAY)) == -1)
                    sleep(3);/* Задержка по времени  */
                else {/* Открытие успешно */
                    fin = popen(msg.cmd_line, "r");/* Исполнение shell cmd, полученной отклиента */
                    write(privatefifo, "\n", 1); /* Подготовка очередного вывода */
                    while ((n = read(fileno(fin), buffer, PIPE_BUF)) > 0) {
                        write(privatefifo, buffer, n);/* Выводв private FIFO кклиенту */
                        memset(buffer, 0x0, PIPE_BUF);/* Очистка буфера */
                    }
                    pclose(fin);
                    close(privatefifo);
                    done = 1;/* Запись произведена успешно */
                }
            } while (++n < 5 && !done);
            if (!done) {/* Указание на неудачный исход */
                write(fileno(stderr), "\nNOTE: SERVER ** NEVER ** accessed private FIFO\n", 48);
                exit(1);
            }
            exit(0);
        }
        waitpid(pid, NULL, WNOHANG);
    }
    return 0;
}
                       

