%option yylineno
%option noinput
%option nounput

%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

extern FILE *yyin;
extern FILE *yyout;

int lineno = 1, column = 1;

void error_handler(char *token, int line, int column);

%}
%x MULTI_LINE_COMMENT

letter 	 [a-zA-Z]
id 			 {letter}+
digit  	 [0-9]
integer  {digit}*
float    [0-9]*(\.[0-9]*)
string   \"[^\"]*\"


%%

<INITIAL>"/*" {
   BEGIN(MULTI_LINE_COMMENT);
}

<MULTI_LINE_COMMENT>"*/" {
   BEGIN(INITIAL);
}

<MULTI_LINE_COMMENT>[^*\n]+

<MULTI_LINE_COMMENT>"*"

<MULTI_LINE_COMMENT>\n {
   lineno++;
}

"else"      { fprintf(yyout,"[Else, %s]\n",yytext); column+=strlen(yytext); }
"if"      	{ fprintf(yyout,"[If, %s]\n",yytext); column+=strlen(yytext); }
"int"      	{ fprintf(yyout,"[Int, %s]\n",yytext); column+=strlen(yytext); }
"return"    { fprintf(yyout,"[Return, %s]\n",yytext); column+=strlen(yytext); }
"void"      { fprintf(yyout,"[Void, %s]\n",yytext); column+=strlen(yytext); }
"while"     { fprintf(yyout,"[While, %s]\n",yytext); column+=strlen(yytext); }

{id}				{ fprintf(yyout,"[Identifier, %s]\n",yytext);  column+=strlen(yytext); }
{integer}		{ fprintf(yyout,"[Int_Literal, %s]\n",yytext); column+=strlen(yytext); }
{float}			{ fprintf(yyout,"[Float, %s]\n",yytext); 				column+=strlen(yytext);	}
{string}		{ fprintf(yyout,"[String, %s]\n",yytext); column+=strlen(yytext); }


"+"      	 	{ fprintf(yyout,"[Sum, %s]\n",yytext); column+=strlen(yytext); }
"-"      	 	{ fprintf(yyout,"[Subtract, %s]\n",yytext); column+=strlen(yytext); }
"*"      	 	{ fprintf(yyout,"[Multiply, %s]\n",yytext); column+=strlen(yytext); }
"/"      	 	{ fprintf(yyout,"[Division, %s]\n",yytext); column+=strlen(yytext); }

"<"       	{ fprintf(yyout,"[LT, %s]\n",yytext); column+=strlen(yytext); }
">"       	{ fprintf(yyout,"[GT, %s]\n",yytext); column+=strlen(yytext); }
"<="       	{ fprintf(yyout,"[LE, %s]\n",yytext); column+=strlen(yytext); }
">="       	{ fprintf(yyout,"[GE, %s]\n",yytext); column+=strlen(yytext); }

"=="       	{ fprintf(yyout,"[Equal, %s]\n",yytext); column+=strlen(yytext); }
"!="       	{ fprintf(yyout,"[Diff, %s]\n",yytext); 	column+=strlen(yytext); }

"="       	{ fprintf(yyout,"[Assign, %s]\n",yytext); column+=strlen(yytext); }

";"       	{ fprintf(yyout,"[Semi, %s]\n",yytext); column+=strlen(yytext); }
","       	{ fprintf(yyout,"[Comma, %s]\n",yytext); column+=strlen(yytext); }
"("       	{ fprintf(yyout,"[LP, %s]\n",yytext); column+=strlen(yytext); }
")"       	{ fprintf(yyout,"[RP, %s]\n",yytext); column+=strlen(yytext); }
"{"       	{ fprintf(yyout,"[LB, %s]\n",yytext); column+=strlen(yytext); }
"}"       	{ fprintf(yyout,"[RB, %s]\n",yytext); column+=strlen(yytext); }
"["       	{ fprintf(yyout,"[LCB, %s]\n",yytext); column+=strlen(yytext); }
"]"       	{ fprintf(yyout,"[RCB, %s]\n",yytext); column+=strlen(yytext); }

"\n"        { lineno += 1; column=1; }

[ \t]+      { column+=strlen(yytext); }

.           { column+=strlen(yytext); error_handler(yytext, lineno, column); }

%%

void error_handler(char *token, int line, int column) {
 printf("ERROR! The character %s is not defined (line: %d, column: %d)\n", token, line, column);
}

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
