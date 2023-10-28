%{
/* 
 * lexical analyzer for a simple calculator.
 * The following tokens are recognized:
 *     floating point numbers.   (NUMBER)
 *     hexadecimal number        (NUMBER)
 *     "sin"                     (SIN)
 *     "cos"                     (COS)
 *     "tan"                     (TAN)
 *     "exp"                     (EXP)
 *     "log"                     (LOG)
 *     "sqrt"                    (SQRT)
 *     "last"                    (LAST)
 *     "hex"                     (HEX)
 *     "pi"                      (NUMBER)
 *     "e"                       (NUMBER)
 *     "**"                      ('^')
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "y.tab.h"

extern int lineno;        /* current line number  */
extern YYSTYPE yylval;    /* value of numeric token */
%}
      
digit       [0-9]
space       [ \t]
hexdigit    [0-9a-fA-F]

%%
{space}                         ;
(0[xX]|\$){hexdigit}+           { yylval = strtol(yytext, 0, 0);
                                  return NUMBER; 
                                }
{digit}+\.?|{digit}*\.{digit}+  { yylval = strtod(yytext, 0); 
                                  return NUMBER; 
                                }

\*\*            { return '^';  }
oct             { return OCT;  }
hex             { return HEX;  }
last            { return LAST; }
cos             { return COS;  }
exp             { return EXP;  }
sin             { return SIN;  }
sqrt            { return SQRT; }
tan             { return TAN;  }
pi              { yylval = atan(1.0) * 4; return NUMBER; }
e               { yylval = exp(1.0);      return NUMBER; }
^\![^\n]+\n     { system(yytext + 1); lineno++; }
\n              { lineno++; return '\n'; }
.               { return yytext[0]; }

%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

