%{
int check_sublist_number = 0;
int count_numbers = 0;
int count_numbers_sublists = 0;
int count_sublists = 0;
int lines = 1;
%}
 
%token NUM
%token SUBLIST_START
%token SUBLIST_END
%token SUB_ID
%token SUB_REALNUMBER
%start line
 
%%
line: _numbers | _nums_and_sublist '\n' line
 
_nums_and_sublist: | nums_and_sublist _nums_and_sublist { 
	if (count_numbers > 0) {
		printf(
			"Строка: %d Всего целых чисел: %d Идентификаторов: %d Вещественных чисел: %d Подсписков: %d\n", lines, count_numbers + count_sublists, count_sublists, count_sublists, count_sublists
		);
		lines++;
		count_numbers_sublists = 0;
		check_sublist_number = 0; 
		count_numbers = 0; 
		count_sublists = 0;
  }
};
 
nums_and_sublist: _numbers { count_numbers += $1; } | _numbers sublist {
	check_sublist_number++;
	count_numbers += $1;
	if (check_sublist_number != $2) {
		return yyerror("Некорректный номер подсписка");
	}
	count_numbers_sublists += count_numbers_sublist;
	count_numbers_sublist = 0;
};

sublist: SUBLIST_START _numbers SUBLIST_END { 
	$$ = $3;
	count_numbers_sublist = $5;
	count_sublists++;
}
 
_numbers: /* empty */ { $$ = 0; } | numbers;

numbers: NUM { $$ = 1; } | NUM ',' numbers { $$ = $3 + 1; };
%%
