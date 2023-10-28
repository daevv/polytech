%{
#include <stdlib.h>
%}

%union
{
    int    ival;
    char * text;
};

%token   <ival> NUMBER 
%token   <text> MONTH
%start   date

%%
date :   MONTH NUMBER ',' NUMBER
            { print($1, $2, $4); }
%%

print (char *m, int d, int y)
{
    printf("%d-%s-%d\n", d, m, y);
    free(m);
}

