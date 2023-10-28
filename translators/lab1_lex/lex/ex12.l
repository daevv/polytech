    int state;

%%
^1     { state = 1; ECHO; }
^2     { state = 2; ECHO; }
^3     { state = 3; ECHO; }
\n     { state = 0; ECHO; }
magic  { switch (state) {
           case 1: printf("<first>");  break;
           case 2: printf("<second>"); break;
           case 3: printf("<third>");  break;
           default : ECHO;
         }
       }
%%

#include "yy.c"

