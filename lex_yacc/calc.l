%option noyywrap

/* definitions */
oprtr [\+\-\/\*]
numbr [0-9]
op_br "\("
cl_br "\)"
blank [ \t]
lettr [a-zA-Z]
punct [,.:;!?@_=\"\'\\{}\[\]]
%{
  #include <stdio.h>
%}
%%
({blank}|{lettr}|{punct})+ 
{oprtr} {printf("operator:(%s) ", yytext);}
{numbr}* {printf("operand:(%s) ", yytext);}
{op_br} {printf("open_bracket ");}
{cl_br} {printf("closed_bracket ");} 
\n {return 0;}
%%

int main(void)
{
  printf("input: ");
  yylex();
  printf("\n[LEXER] equation tokenized succesfully!\n"); 
 

  printf("\n");
  return 0;
}
