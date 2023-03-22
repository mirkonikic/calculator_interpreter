%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *);
  #define RED   "\x1B[31m"
  #define GRN   "\x1B[32m"
  #define YEL   "\x1B[33m"
  #define BLU   "\x1B[34m"
  #define MAG   "\x1B[35m"
  #define CYN   "\x1B[36m"
  #define WHT   "\x1B[37m"
  #define RESET "\x1B[0m"
%}
%token id
%token op
%token op_br
%token cl_br
%token nw_ln
%token quit
%token banner
%%
program : program S nw_ln
  |
  ;

S : E { printf(BLU "output:" WHT " %d\n\n" BLU "input: " WHT, $1); }
  | quit {return 1;}
  | banner { printf(RED "\t[_] CALC INTERP v0.1 [_]\n\n" WHT "\t\t ..by mirkonikic\n" YEL "usage: \n\t\t" RED " operators: " WHT "+ - * / ( )\n\t\t" RED " data types: " WHT "int\n\t\t" RED " cmds: " WHT "banner() quit()\n\n" BLU "input: "
  WHT); }
  | 
  ;

E : id { printf("E = %d\n", $1); $$ = $1; }
  | E op E { 
              printf(CYN "parsed: " RESET "%d %c %d\n", $1, $2, $3); 
              switch ($2)
              {
                case '+':
                  $$ = $1 + $3; 
                  break;
                case '-':
                  $$ = $1 - $3; 
                  break;
                case '*':
                  $$ = $1 * $3; 
                  break;
                case '/':
                  $$ = $1 / $3; 
                  break;
                default:
                  break;
              }
            } 
  | op_br E cl_br { printf("(%d)\n", $2); $$ = $2;}
  ;

%%

void yyerror(char *s){
  fprintf(stderr, "error: %s\n", s);
}

int main(void)
{
  printf(BLU "input: " RESET);
  //yylex();
  //printf("\n[LEXER] equation tokenized succesfully!\n"); 
  yyparse();
  
  printf("end! \n");
  return 0;
}
