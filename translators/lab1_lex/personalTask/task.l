%{
#include <stdio.h>
%}

%option noyywrap

%%
[0-9]+        { printf("INTEGER: %s\n", yytext); }
[a-zA-Z][a-zA-Z0-9]*     { printf("IDENTIFIER: %s\n", yytext); }
[-+*/]         { printf("OPERATOR: %s\n", yytext); }
[-+]+         { printf("UNARY OPERATOR: %s\n", yytext); }
\n            { /* игнорируем символы новой строки */ }
[ \t]         { /* игнорируем пробелы и табуляцию */ }
.             { printf("ERROR: %s\n", yytext); }

%%

int main() {
    yylex(); /* Запуск анализатора */
    return 0;
}
