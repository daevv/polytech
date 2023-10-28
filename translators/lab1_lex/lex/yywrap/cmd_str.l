    int lineno = 0;

%%
\n  lineno++;
.   ;
%%

typedef struct {
    int     argc;
    char ** argv;
} t_cmd;        

t_cmd cmd;

int open_next_file ()
{
    static int arg_no = 1;
    char *p;

    if (arg_no < cmd.argc) {
        p = cmd.argv[arg_no++];
        yyin = fopen(p, "r");
        fprintf(stderr, "<-- open_next_file: %s -->\n", p);
        return 1;
    }
    return 0;                   
}

int yywrap() 
{ 
    printf("lines %d\n", lineno);
    return (!open_next_file());
}    

int main (int argc, char **argv)
{
#if 0   
    int i;

    fprintf(stderr, "Parameters are\n");
    for (i = 0; i < argc; i++) {
        fprintf(stderr, "%d: %s\n", i, argv[i]);
    }    
#endif  
    cmd.argc = argc; 
    cmd.argv = argv;
    if (argc > 1) {         // else (if no files denoted), we work with stdio
        open_next_file();
    }           
    while (yylex());
    return 0;
}
     
