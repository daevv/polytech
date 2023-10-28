#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>

int main(int argc, char **argv) 
{
	if (argc < 3) 
	{
		printf("Usage %s cmd1 ... cmdn\n", argv[0]);
		exit(1);
	}
	int pfd[argc - 2][2];
	pid_t pid[argc - 1];
	pipe(pfd[0]);
	if ((pid[0] = fork()) == 0) 
	{
		dup2(pfd[0][1], 1);
		close(pfd[0][0]);
		close(pfd[0][1]);
		execlp(argv[1], argv[1], NULL);
	}
	int k = 1;
	for (; k < argc - 2; k++) 
	{
		pipe(pfd[k]);
		if ((pid[k] = fork()) == 0) 
		{
			dup2(pfd[k-1][0], 0);
			dup2(pfd[k][1], 1);
			close(pfd[k-1][0]);
			close(pfd[k-1][1]);
			close(pfd[k][0]);
			close(pfd[k][1]);
			execlp(argv[k+1], argv[k+1], NULL);
		}
		close(pfd[k-1][0]);
		close(pfd[k-1][1]);
	}
	if ((pid[k] = fork()) == 0) 
	{
		dup2(pfd[k-1][0], 0);
		close(pfd[k-1][0]);
		close(pfd[k-1][1]);
		execlp(argv[k+1], argv[k+1], NULL);
	}
	close(pfd[k-1][0]);
	close(pfd[k-1][1]);
	for (int i = 0; i < k + 1; i++)
	{
		waitpid(pid[i], NULL, 0);
	}
}
