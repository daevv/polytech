%{
#include "y.tab.h"
%}

DIGIT [0-9]
ID #[0-9]*
FLOAT ([0-9]+[.][0-9]*)
SPACE [ \t]+

%%
"(" { return SUBLIST_START; }
")" { return SUBLIST_END; }
{DIGIT}+ { yylval.integer = atoi(yytext); return NUM; }
{FLOAT} { yylval.real = atof(yytext); return NUM; }
{ID} { yylval.identifier = strdup(yytext); return ID; }
"," { return COMMA; }
{SPACE} { /* skip whitespace */ }
\n { return NEWLINE; }
. { /* skip other characters */ }
%%

int yywrap() {
    return 1;
}
