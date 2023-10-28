%{
void skip_comments();
%}

D   [0-9]
H   [0-9A-Fa-f]
L   [_A-Za-z]

%%
{L}({L}|{D})*   printf( "ident: %s\n", yytext );
0{H}+(H|h)?     |
{D}{H}*(H|h)    printf( "hex: %s\n", yytext );
{D}+            printf( "decimal: %s\n", yytext );
"/*"            skip_comments();
.               ;
%%

void skip_comments()
{
    int c = '*';	/* not char! */

    while( c != '/' ) {
        while( input() != '*' );
            c = input();
        if( c != '/' ) 
            unput (c);
    }
}

#include "yy.c"

