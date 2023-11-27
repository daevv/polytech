%token NUM
%start __list

%%
__list: _list       { printf("No. of items: %d\n", $1); }

_list: /* empty */  { $$ = 0; /* size is 0 */ }
      | list        /* not empty, $$ == $1 by default */
      ;

list: NUM           { $$ = 1; }       /* size := 1 */
    | NUM ',' list  { $$ = $3 + 1; }  /* size := size of sublist + 1 */
    ;
%%

