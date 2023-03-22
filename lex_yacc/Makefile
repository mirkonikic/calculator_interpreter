all:
	yacc -d calc.y
	lex calc.l
	gcc -o calc lex.yy.c y.tab.c
	./calc

lex:
	lex calc.l
	gcc -o calc lex.yy.c

yacc:

run:
	./calc
