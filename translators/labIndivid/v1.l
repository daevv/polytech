%{
#include <stdlib.h>
#include "y.tab.h"
%}

D [0-9]
L [A-z]
W [A-z_0-9]

%%

"="	{ return ASSIGN; }
";"	{ return SEMI; }

int         { return INT; }

{L}{W}*	{ yylval.value = strdup(yytext); return ID; }
{D}+              { yylval.value = strdup(yytext); return CONST; }
"&"                { yylval.value = strdup(yytext); return AND; }
"|"                { yylval.value = strdup(yytext); return OR; }
"~"                 { yylval.value = strdup(yytext); return NOT; }
"("                 { yylval.value = strdup(yytext); return LPAREN; }
")"                 { yylval.value = strdup(yytext); return RPAREN; }
	
[ \0\t]+ ;
\n	;
.	;
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif
