   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   int parentheses;
   int brackets;
   int operators;
   int numbers;
   int equal;  
   int pos = 1;
   int line = 1;


%}

   /* some common rules */
DIGIT                [0-9]
LETTERS              [a-zA-Z]
DIGITS               {0-9}*
IDENTIFIER_WORD      {LETTERS}(({LETTERS}|[_]|{DIGIT})*({LETTERS}|DIGIT)+)*



%%
   /* specific lexer rules in regex */
{DIGIT}+       {printf("NUMBER %s\n", yytext); ++numbers;}
function       {printf("FUNCTION\n"); pos += yyleng;}
beginparams    {printf("BEGIN_PARAMS\n"); pos+=yyleng;}
endparams      {printf("END_PARAMS\n"); pos += yyleng;}
beginlocals    {printf("BEGIN_LOCALS\n"); pos += yyleng;}
endlocals      {printf("END_LOCALS\n"); pos += yyleng;}
beginbody      {printf("BEGIN_BODY\n"); pos += yyleng;}
endbody        {printf("END_BODY\n"); pos += yyleng;}
integer        {printf("INTEGER\n"); pos += yyleng;}
array          {printf("ARRAY\n"); pos += yyleng;}
of             {printf("OF\n"); pos += yyleng;}
if             {printf("IF\n"); pos += yyleng;}
then           {printf("THEN\n"); pos += yyleng;}
endif          {printf("ENDIF\n"); pos += yyleng;}
else           {printf("ELSE\n"); pos += yyleng;}
while          {printf("WHILE\n"); pos += yyleng;}
do             {printf("DO\n"); pos += yyleng;}
beginloop      {printf("BEGINLOOP\n"); pos += yyleng;}
endloop        {printf("ENDLOOP\n"); pos += yyleng;}
continue       {printf("CONTINUE\n"); pos += yyleng;}
break          {printf("BREAK\n"); pos += yyleng;}
read           {printf("READ\n"); pos += yyleng;}
write          {printf("WRITE\n"); pos += yyleng;}
not            {printf("NOT\n"); pos += yyleng;}
true           {printf("TRUE\n"); pos += yyleng;}
false          {printf("FALSE\n"); pos += yyleng;}
return         {printf("RETURN\n"); pos += yyleng;}
"-"            {printf("SUB\n"); pos += yyleng; ++operators;}
"+"            {printf("ADD\n"); pos += yyleng; ++operators;}
"*"            {printf("MULT\n"); pos += yyleng; ++operators;}
"/"            {printf("DIV\n"); pos += yyleng; ++operators;}
"%"            {printf("MOD\n"); pos += yyleng; ++operators;}
";"            {printf("SEMICOLON\n"); pos += yyleng; ++operators;}
":"            {printf("COLON\n"); pos += yyleng; ++operators;}
","            {printf("COMMA\n"); pos += yyleng; ++operators;}
"("            {printf("L_PAREN\n"); pos += yyleng; ++parentheses;}
")"            {printf("R_PAREN\n"); pos += yyleng; ++parentheses;}
"["            {printf("L_SQUARE_BRACKET\n"); pos += yyleng; ++brackets;}
"]"            {printf("R_SQUARE_BRACKET\n"); pos += yyleng; ++brackets;}
"=="           {printf("EQ\n"); pos += yyleng; ++operators;}
"<>"           {printf("NEQ\n"); pos += yyleng; ++operators;}
"<"            {printf("LT\n"); pos += yyleng; ++operators;}
">"            {printf("GT\n"); pos += yyleng; ++operators;}
"<="           {printf("LTE\n"); pos += yyleng; ++operators;}
">="           {printf("GTE\n"); pos += yyleng; ++operators;}
":="           {printf("ASSIGN\n"); pos += yyleng; ++operators;}
("##").*       {pos += yyleng;}
[ \t]+         {pos += yyleng;}
"\n"           {line++; pos = 1;}
{IDENTIFIER_WORD}   {printf("IDENT %s\n", yytext); pos += yyleng;}
.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", line, pos, yytext); exit(0);}



%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
   /*printf("Number of integers: %d\n", numbers);*/
   /*printf("Number of parentheses: %d\n", parentheses);*/ 
   /*printf("Number of operators: %d\n", operators);*/
}
