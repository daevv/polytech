/* It won't work if unput changes yyleng & yytext */

    int  i;

%%
\@[A-Za-z]+   {
                  for( i = 1; i < yyleng; i++ )
                      unput( yytext[i] );
              }
%%

#include "yy.c"

