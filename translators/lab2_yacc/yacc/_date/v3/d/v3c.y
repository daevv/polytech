%{
#define YYSTYPE long

long abs_date (long, long, long);	/* month (0-11), day, year */
%}

%token  NUMBER MONTH
%start  between

%%
date :    MONTH NUMBER ',' NUMBER
            { $$ = abs_date($1, $2, $4); }

between : date '-' date
            { printf("%ld\n", $1 - $3); }
%%
