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
  #define RED   "\x1B[31m"
  #define GRN   "\x1B[32m"
  #define YEL   "\x1B[33m"
  #define BLU   "\x1B[34m"
  #define MAG   "\x1B[35m"
  #define CYN   "\x1B[36m"
  #define WHT   "\x1B[37m"
  #define RESET "\x1B[0m"
%}
%%
"quit()" {return quit;}
"banner()" {return banner;}
({blank}|{lettr}|{punct})+ ;
{oprtr} {
          printf(GRN "operator:" RESET "(%s) ", yytext);
          yylval = yytext[0];
          return op;
        }
{numbr}* {
            printf(YEL "operand:" RESET "(%s) ", yytext);
            yylval = atoi(yytext);
            return id;
          }
{op_br} {
          printf(MAG "\nopen_bracket " RESET);
          return op_br;
        }
{cl_br} {
          printf(RED "closed_bracket\n" RESET);
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
