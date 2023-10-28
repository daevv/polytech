%{
int count = 0;
%}

%%
[-+]?[0-9]+  {
                count++;
                printf( "%d %s\n", count, yytext );
             }
%%

#include "yy.c"

