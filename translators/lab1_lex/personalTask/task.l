%{
#include <stdio.h>
%}

OPERATOR [\+\-\*/]
DIGIT [0-9]+
LETTER [A-Za-z]
IDENTIFIER ({LETTER}+{DIGIT}*)

%%

^[\+\*/].* { printf("Ошибка: Оператор в начале строки не является унарным - %s\n", yytext); }
.*{OPERATOR}{DIGIT}{IDENTIFIER}.*	 { printf("Ошибка: неправильный формат идентификатора - %s\n", yytext); }
{DIGIT}{IDENTIFIER}.* { printf("Ошибка: неправильный формат идентификатора - %s\n", yytext); }
^\-?{DIGIT} { printf("R1:=%s\n", yytext); }
^\-?{IDENTIFIER} { printf("R1:=%s\n", yytext); }
{OPERATOR}{DIGIT} { printf("R1:=R1%s\n", yytext); }
{OPERATOR}{IDENTIFIER} { printf("R1:=R1%s\n", yytext); }
{OPERATOR}{OPERATOR}.* { printf("Ошибка: два оператора подряд - %s\n", yytext); }

\n                { printf("-------\n"); }
\r                { printf("-------\n"); }
.                { printf("Ошибка: Недопустимый символ - %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
