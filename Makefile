tradutor:
	flex src/lexico.l;
	gcc lex.yy.c -o tradutor -lfl;
	cp lex.yy.c ./src;
	rm lex.yy.c;