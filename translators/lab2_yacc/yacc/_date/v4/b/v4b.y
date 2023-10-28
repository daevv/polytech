%union
{
    int    ival;
    char * text;
};

%token   NUMBER MONTH
%start   date

%%
date :   MONTH NUMBER ',' NUMBER
            { print($<text>1, $<ival>2, $<ival>4); }
%%

int print (char *m, int d, int y)
{
    printf("%d-%s-%d\n", d, m, y);
}

