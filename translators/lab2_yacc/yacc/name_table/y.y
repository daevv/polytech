%{
#include "nametab.h"
void add_name (char *);
%}

%union
{
    int    ival;
    char * text;
};

%token  ASSIGN DO ELSE END FI IF IN INTEGER LET READ SKIP THEN WHILE WRITE
%token  <ival> NUMBER
%token  <text> IDENTIFIER

%left   '-' '+'
%left   '*' '/'
%right  '~'

%start   declaration

%%
declaration : /* empty */ 
            | INTEGER id_seq ';'    { print_names("Result tab:\n"); }
            ;

id_seq  : IDENTIFIER                { add_name($1); }
        | id_seq ',' IDENTIFIER     { add_name($3); }
        ;
%%

void add_name (char *s)
{
    if (insert_name(s))
        return;
    fprintf(stderr, "Error: duplicated name <%s>\n", s);
    exit(1);
}       

#ifndef yyerror
yyerror( char *s ) { fprintf( stderr, "%s\n", s ); }
#endif

main () { return yyparse(); }

