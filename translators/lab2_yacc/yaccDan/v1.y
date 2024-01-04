%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();

int integer_count = 0;
int sublist_count = 0;
int lines_counter = 1;

%}

%union {
  int integer_val;
  double real_val;
  char *identifier;
}

%token <integer_val> INTEGER
%token <real_val> REAL
%token <identifier> IDENTIFIER
%token LPAREN RPAREN COMMA NEWLINE

%%

input:
  | input line
  ;

line:
  NEWLINE                { 
		printf("Строка %d, Целых чисел: %d, Вещественных чисел: %d, Идентификаторов: %d, Подсписков: %d\n", lines_counter, integer_count + sublist_count, sublist_count, sublist_count, sublist_count); 
		sublist_count = 0; 
		lines_counter++;
		integer_count = 0;
		}
  | expr NEWLINE { 
		printf("Строка %d, Целых чисел: %d, Вещественных чисел: %d, Идентификаторов: %d, Подсписков: %d\n", lines_counter, integer_count + sublist_count, sublist_count, sublist_count, sublist_count); 
		sublist_count = 0; 
		lines_counter++;
		integer_count = 0;

		}
  ;

expr:
  | INTEGER                { integer_count++; }
  | LPAREN sublist RPAREN { sublist_count++; }
  | expr COMMA expr
  ;

sublist: REAL COMMA INTEGER COMMA IDENTIFIER
	| REAL COMMA IDENTIFIER COMMA INTEGER
	| INTEGER COMMA IDENTIFIER COMMA REAL
	| INTEGER COMMA REAL COMMA IDENTIFIER
	| IDENTIFIER COMMA REAL COMMA INTEGER
	| IDENTIFIER COMMA INTEGER COMMA REAL
  ;

%%