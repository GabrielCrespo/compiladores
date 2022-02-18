%{
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
%}
id 			[a-zA-Z][a-zA-Z0-9]*
digito  [0-9]
integer {digito}*
float   [0-9]*(\.[0-9]*)
branco 	[ \t\n]+
outro 	.

%%
{id}			{ fprintf(yyout,"[Identificador, %s]\n",yytext); }
{integer}	{ fprintf(yyout,"[Inteiro, %s]\n",yytext); }
{float}		{ fprintf(yyout,"[Ponto flutuante, %s]\n",yytext); }
"+"       { fprintf(yyout,"[Adição, %s]\n",yytext); }
"="       { fprintf(yyout,"[Atribuição, %s]\n",yytext); }
{outro}		{ fprintf(yyout,"[Outro, %s]\n",yytext); }
{branco}	{ ; }
%%
/* recomendavel declarar sempre funcao yywrap() */
int yywrap ();

/* programa principal */
int main(argc, argv)
 int argc;
 char **argv;
    {
	++argv; --argc; 	    /* abre arquivo de entrada se houver */
	if(argc > 0)
		yyin = fopen(argv[0],"rt");
	else
		yyin = stdin;    /* cria arquivo de saida se especificado */
	if(argc > 1)
		yyout = fopen(argv[1],"wt");
	else
		yyout = stdout;
	yylex(); /* scanner gerado por Flex */
	fclose(yyin);
	fclose(yyout);
    }

int yywrap() {
	return 1;
}
