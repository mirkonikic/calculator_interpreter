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
  #include "y.tab.h"
%}
%%
"quit()" {return quit;}
"banner()" {return banner;}
({blank}|{lettr}|{punct})+ ;
{oprtr} {
          printf("operator:(%s) ", yytext);
          yylval = yytext[0];
          return op;
        }
{numbr}* {
            printf("operand:(%s) ", yytext);
            yylval = atoi(yytext);
            return id;
          }
{op_br} {
          printf("\nopen_bracket ");
          return op_br;
        }
{cl_br} {
          printf("closed_bracket\n");
          return cl_br;
        } 
\n {
    return nw_ln;
   }
%%

int yywrap(void){
  return 1;
}

/*
int main(void)
{
  printf("input: ");
  yylex();
  printf("\n[LEXER] equation tokenized succesfully!\n"); 
 

  printf("\n");
  return 0;
}
*/
