%token NUM
%start __list

%%
__list: _list

_list: /* empty */  { $$ = 0; }
      | list        
      ;

list: NUM       { $$ = 1; print($$, $1, 1); }           
    | NUM 
      ',' 
      list      { $$ = $3 + 1; print($$, $1, 2); }
    ;
%%

print (int len, int val, int rule)
{ 
    printf("%d: %d (rule %d)\n", len, val, rule) ;
}

