%%
read    { printf( "operation: " ); ECHO; }
[a-z]+  { printf( "identifier: " ); ECHO; }
%%

#include "yy.c"

