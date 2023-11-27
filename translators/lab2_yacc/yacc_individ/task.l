%{
#include <stdlib.h>
#include "y.tab.h"

#define YYSTYPE int
extern YYSTYPE yylval;    /* value of numeric token */
%}

ID (#{NUMBER})
NUMBER [0-9]+
REALNUMBER ({NUMBER}\.{NUMBER})


%%
{NUMBER}	{ yylval = atoi(yytext); return NUM; }
(\ *,\ *)?\( 		return SUBLIST_START;
{ID}            return SUB_ID;
{REALNUMBER}    return SUB_REALNUMBER;
\)(\ *,\ *)? 		return SUBLIST_END;
\ +         		;
(.|\n)      		return yytext[0];
%%
 
#ifndef yywrap
int yywrap () { return 1; }
#endif
