%%
(.)+    { 
          printf(">%s\n", yytext); 
          if (yyleng > 1) yyless(yyleng/2); 
        }
%%

/*
%%
(.)+	    { 
	      printf(">%s\n", yytext); 
	      if (yyleng > 1) yyless(yyleng/2); 
	    }
(.|\n)	    ;
%%
*/

#include "yy.c"

