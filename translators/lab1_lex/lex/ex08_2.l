    int   i, len;
    char  *p; 

%%
\@[A-Za-z]+    {
                 len = yyleng;
                 p = (char *)strdup(yytext);

                 for( i = 1; i < len; i++ )
                     unput( p[i] );
               }
%%

#include "yy.c"

