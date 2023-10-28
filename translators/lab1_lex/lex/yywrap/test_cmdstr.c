#include <stdio.h>

int main (int argc, char **argv)
{
    int i;

    printf("Parameters are\n", argc);
    for (i = 1; i < argc; i++)
        printf("%d: %s\n", i, argv[i]);
    printf("\n");
    return 0;
}

