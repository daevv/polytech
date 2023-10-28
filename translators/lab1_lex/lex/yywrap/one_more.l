    int lineno = 0;
    char *p = "one_more.l";

%%
\n  lineno++;
.   ;
%%

int yywrap() 
{ 
    printf("lines %d\n", lineno);
    fprintf(stderr, "<-- End of text, ");
    if (p) {
        fprintf(stderr, "continue with %s -->\n", p);
        yyin = fopen(p, "r");
        p = NULL;
        return 0;
    }
    fprintf(stderr, "Normal shutdown -->\n");
    return 1;
}    

main () { while (yylex()); }

