%token NUM
%start __list

%%
__list: _list '\n'  { printf("No. of items: %d\n", $1); }

_list:  /* empty */ { $$ = 0; }
     | list      
     ;

list: NUM           { $$ = 1; }
    | NUM ',' list  { $$ = $3 + 1; }
    ;
%%

