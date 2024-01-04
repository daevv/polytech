%{
#include "y.tab.h"
%}

%%

[0-9]+                  { yylval.integer_val = atoi(yytext); return INTEGER; }
[0-9]+\.[0-9]+          { yylval.real_val = atof(yytext); return REAL; }
[a-zA-Z][a-zA-Z0-9]*  { yylval.identifier = strdup(yytext); return IDENTIFIER; }
"("                      { return LPAREN; }
")"                      { return RPAREN; }
,                       { return COMMA; }
\n                      { return NEWLINE; }
[ \t]                   ;  /* пропуск пробелов и табуляций */

.                       { fprintf(stderr, "Нераспознанный символ: %s\n", yytext); }

%%

#ifndef yywrap
int yywrap () { return 1; }
#endif


 
