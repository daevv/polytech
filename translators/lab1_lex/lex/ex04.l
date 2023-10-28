%%
[0-9]+     |
[a-zA-Z]+  { ECHO; printf( "\n" ); }
.|\n       ;
%%

#include "yy.c"

