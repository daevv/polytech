%{
#include "y.tab.h"
%}

%%
[0-9]+      { return NUMBER; }
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
dec         { return MONTH; }
[ \t\n]     ;
.           { return 0; }
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

