%token  NUMBER MONTH
%start  date

%%
date :  MONTH NUMBER ',' NUMBER
            { printf("m-d-y: %2u-%2u-%4u\n", $1+1, $2, $4); }
%%
