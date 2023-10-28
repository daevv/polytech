%START c1 c2 c3

%%
^1         { ECHO; BEGIN c1; }
^2         { ECHO; BEGIN c2; }
^3         { ECHO; BEGIN c3; }
\n         { ECHO; BEGIN 0;  }
<c1>magic  printf( "<first>"  );
<c2>magic  printf( "<second>" );
<c3>magic  printf( "<third>"  );
%%

#include "yy.c"

