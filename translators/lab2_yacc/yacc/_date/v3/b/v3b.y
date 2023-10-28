%{
long abs_date (int, int, int);	/* month (0-11), day, year */
%}

%token  NUMBER MONTH
%start  date

%%
date :  MONTH NUMBER ',' NUMBER
            { printf("%ld\n", abs_date($1, $2, $4)); }
%%
