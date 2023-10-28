%union
{
    int  ival;
    char cval;
};

%{
void SetBrunch (char cond, int label);
void SetJump (int label);
%}

%token   REPEAT UNTIL WHILE END IF ELSE ELSIF UNKNOWN 
%token   <cval> COND
%start   seq

%%
seq : stat
    | stat seq 
    ;

stat : repeat 
     | while
     | UNKNOWN
     ;

repeat :    REPEAT 
            { $<ival>$ = SetLabel(NextLabel()); } 
            seq 
            UNTIL 
            COND
            { SetBrunch($5, $<ival>2); }

while :     WHILE 
            { $<ival>$ = SetLabel(NextLabel()); }
            COND
            { $<ival>$ = NextLabel(); SetBrunch($3, $<ival>$); } 
            seq 
            END 
            { SetJump($<ival>2); SetLabel($<ival>4); }
%%

NextLabel ()
{
    static int n_label = 0;
    return ++n_label;
}

SetLabel (int label)
{
    printf("l%d:", label);
    return label;
}

void SetBrunch (char cond, int label)
{
    printf("jn%c l%d\n", cond, label);
}

void SetJump (int label)
{
    printf("jmp l%d\n", label);
}

