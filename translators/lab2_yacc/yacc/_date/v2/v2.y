%token   NUMBER MONTH
%start   date

%%
date :   MONTH NUMBER ',' NUMBER
%%
