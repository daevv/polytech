%{
#include <stdlib.h>
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.ival = atoi(yytext); return NUMBER; }
jan         { yylval.ival =  0; return MONTH; }
feb         { yylval.ival =  1; return MONTH; }
march       { yylval.ival =  2; return MONTH; }
apr         { yylval.ival =  3; return MONTH; }
may         { yylval.ival =  4; return MONTH; }
june        { yylval.ival =  5; return MONTH; }
july        { yylval.ival =  6; return MONTH; }
aug         { yylval.ival =  7; return MONTH; }
sep         { yylval.ival =  8; return MONTH; }
oct         { yylval.ival =  9; return MONTH; }
nov         { yylval.ival = 10; return MONTH; }
dec         { yylval.ival = 11; return MONTH; }
[ \t\n]     ;
.           { return yytext[0]; }
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

