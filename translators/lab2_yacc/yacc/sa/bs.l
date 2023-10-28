%{
#include "y.tab.h"
%}

%start  Cond

%%
<INITIAL>"//"(.*)   ; /* comment */
<INITIAL>repeat     { return REPEAT; }
<INITIAL>while      { BEGIN Cond; return WHILE; }
<INITIAL>if         { BEGIN Cond; return IF; }
<INITIAL>elsif      { BEGIN Cond; return ELSIF; }
<INITIAL>else       { return ELSE; }
<Cond>[ \t\n]+      ;
<Cond>(.)           { BEGIN 0; yylval.cval = yytext[0]; return COND; }
<INITIAL>until      { BEGIN Cond; return UNTIL; }
<INITIAL>end        { BEGIN 0; return END; }
<INITIAL>(.|\n)     { ECHO; return UNKNOWN; }                   
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

