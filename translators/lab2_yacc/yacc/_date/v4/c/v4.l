%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.ival = atoi(yytext); return NUMBER; }
jan         |
feb         |
march       |
apr         |
may         |
june        |
july        |
aug         |
sep         |
oct         |
nov         |
dec         { yylval.text = strdup(yytext); return MONTH; }
","         { return yytext[0]; }
[ \t\n]     ;
.           { return 0; }
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

