	%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#include "malloc.h"
#include <ctype.h>

#define MAX_VARS 100
#define MAX_EXPRESSION_SIZE 100
#define MAX_SIZE 100

struct Variable {
    char name[20];
    int initialized;
		char expression[100];
		char polska[100];
};

struct Variable variables[MAX_VARS];
int varCount = 0;


void error(const char* msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(EXIT_FAILURE);
}

char stack[MAX_SIZE];
int top = -1;

// Проверка, является ли символ оператором
int isOperator(char c) {
    return (c == '&' || c == '|' || c == '~');
}

// Получение приоритета оператора
int getPriority(char op) {
    if (op == '&') {
        return 2;
    } else if (op == '|') {
        return 1;
    } else if (op == '~') {
        return 3;
    }
    return 0;  // Для скобок
}

// Добавление оператора в стек
void push(char op) {
    if (top < MAX_SIZE - 1) {
        stack[++top] = op;
    } else {
        printf("Ошибка: стек переполнен\n");
    }
}

// Извлечение оператора из стека
char pop() {
    if (top >= 0) {
        return stack[top--];
    } else {
        printf("Ошибка: стек пуст\n");
    }
}

// Преобразование выражения в обратную польскую запись
void infixToPostfix(char infix[], char postfix[]) {
    int i, j;
    char ch;

    j = 0;

    for (i = 0; infix[i] != '\0'; i++) {
        ch = infix[i];

        if (isalnum(ch)) {
            postfix[j++] = ch;
						postfix[j++] = ' ';
        } else if (ch == '(') {
            push(ch);
        } else if (ch == ')') {
            while (top >= 0 && stack[top] != '(') {
                postfix[j++] = pop();
								postfix[j++] = ' ';
            }
            if (top >= 0 && stack[top] == '(') {
                pop();  // Извлекаем '(' из стека
            } else {
                printf("Ошибка: неправильное расположение скобок\n");
            }
        } else if (isOperator(ch)) {
            while (top >= 0 && getPriority(stack[top]) >= getPriority(ch)) {
                postfix[j++] = pop();
								postfix[j++] = ' ';
            }
            push(ch);
        }
    }

    // Извлечение оставшихся операторов из стека
    while (top >= 0) {
        postfix[j++] = pop();
				postfix[j++] = ' ';
    }

    postfix[j] = '\0';  // Завершаем строку
}


%}

%union {
	char* value;
	int numb;
}

%token SEMI 
%token <value> ID CONST AND OR NOT LPAREN RPAREN
%token ASSIGN INT

%left OR
%left AND
%right NOT

%type <value> init
%type <value> expression

%start lines

%%
lines: line
	| line lines
	;

line: init 
	| assignment;

init: INT ID SEMI {  
	int i;
	for (i = 0; i < varCount; i++) {
    if (strcmp(variables[i].name, $2) == 0) {
			error("Variable already declared");
      break;
    }
  }
	if (i == varCount) {
		if (varCount < MAX_VARS) {
      strcpy(variables[varCount].name, $2);
      varCount++;
    } else {
      error("Too many variables");
    }
	}
	printf("Value was declared: %s . Type INT\n", $2);
};


assignment: ID ASSIGN expression SEMI {

	int i;
  for (i = 0; i < varCount; i++) {
    if (strcmp(variables[i].name, $1) == 0) {
      if (variables[i].initialized) {
        error("Variable has already been initialized");
      } else {
				
				char infix[MAX_SIZE], postfix[MAX_SIZE];
				variables[i].initialized = 1;
        strcpy(variables[i].expression, $3);
        strcpy(infix, $3);

				size_t len = strlen(infix);
				if (infix[len - 1] == '\n') {
						infix[len - 1] = '\0';
				}

				infixToPostfix(infix, postfix);
				strcpy(variables[i].polska, postfix);
      }
      break;
    }
  }
	if (i == varCount) {
		error("Variable was not declared");
	}
	printf("Value %s was initialized: %s , RPN: %s \n", variables[i].name, variables[i].expression, variables[i].polska );
};

expression : CONST { $$ = $1;}
           | ID { $$ = $1;} 
           | NOT expression %prec NOT { $$ = strcat($1, $2);}
           | expression AND expression { $$ = strcat(strcat($1, $2), $3);}
           | expression OR expression { $$ = strcat(strcat($1, $2), $3);}
           | LPAREN expression RPAREN { $$ = strcat(strcat($1, $2), $3);}
           ;
%%

int main () 
{ 
	yyparse();
	return 0;
}

int yyerror (char *s) 
{ 
	fprintf( stderr, "?-%s\n", s ); 
}
