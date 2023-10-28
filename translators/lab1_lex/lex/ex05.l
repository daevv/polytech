    int len[40], i;

%%
        {
          for( i = 0; i < 40; i++ )
            len[i] = 0;
        }
[a-z]+  len[yyleng]++;
.|\n    ;
%%

#ifndef yywrap
int yywrap() { return 1; }
#endif

main() 
{ 
    while( yylex() ); 
    for( i = 0; i < 40; i++ )
        if( len[i] > 0 )
            printf( "%5d%10d\n", i, len[i] );
}

