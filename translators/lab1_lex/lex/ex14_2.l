    int s = 0, h = 0;

%%
she    { s++; REJECT; }
he     { h++; REJECT; }
.|\n   ;
%%

#ifndef yywrap
int yywrap() { return( 1 ); }
#endif

main() 
{ 
    while( yylex() ); 
    printf( "she: %d times, he: %d times\n", s, h );    
}

