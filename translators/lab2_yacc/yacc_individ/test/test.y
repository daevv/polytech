%{
#include <stdio.h>
#include <stdlib.h>

int countIntegers = 0;
int countIdentifiers = 0;
int countFloats = 0;
int countSublists = 0;
int countLines = 0;

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}

%}

%token NUM ID SUBLIST_START SUBLIST_END COMMA NEWLINE

%start lines

%%

lines: lines line
      | line

line: '\n' { countLines++; }
    | elements '\n' { countLines++; }

elements: /* empty */ { countIntegers = 0; countIdentifiers = 0; countFloats = 0; countSublists = 0; }
         | elements element { /* Do nothing, just accumulate counts */ }

element: NUM { countIntegers++; }
       | ID { countIdentifiers++; }
       | NUM { countFloats++; }
       | SUBLIST_START elements SUBLIST_END { countSublists++; }

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    yyparse();

    printf("Total lines: %d\n", countLines);
    printf("Total integers: %d\n", countIntegers);
    printf("Total identifiers: %d\n", countIdentifiers);
    printf("Total floats: %d\n", countFloats);
    printf("Total sublists: %d\n", countSublists);

    fclose(yyin);
    return 0;
}
