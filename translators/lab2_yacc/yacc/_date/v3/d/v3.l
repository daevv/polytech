%{
#include <stdlib.h>
#include "y.tab.h"

#define YYSTYPE long
extern YYSTYPE yylval;
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
jan         { yylval =  0; return MONTH; }
feb         { yylval =  1; return MONTH; }
march       { yylval =  2; return MONTH; }
apr         { yylval =  3; return MONTH; }
may         { yylval =  4; return MONTH; }
june        { yylval =  5; return MONTH; }
july        { yylval =  6; return MONTH; }
aug         { yylval =  7; return MONTH; }
sep         { yylval =  8; return MONTH; }
oct         { yylval =  9; return MONTH; }
nov         { yylval = 10; return MONTH; }
dec         { yylval = 11; return MONTH; }
[ \t\n]     ;
.           { return yytext[0]; }	/* literal */
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

