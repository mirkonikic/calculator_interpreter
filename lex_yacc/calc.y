%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *);
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

S : E { printf("output: %d\ninput: ", $1); }
  | quit {return 1;}
  | banner { printf("\t[_] CALC INTERP v0.1 [_]\n\n\t\t ..by mirkonikic\nusage: \n\t\t operators: + - * / ( )\n\t\t data types: int\n\t\t cmds: banner() quit()\n"); }
  | 
  ;

E : id { printf("E = %d\n", $1); $$ = $1; }
  | E op E { 
              printf("parsed: %d %c %d\n", $1, $2, $3); 
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
  printf("input: ");
  //yylex();
  //printf("\n[LEXER] equation tokenized succesfully!\n"); 
  yyparse();
  
  printf("end! \n");
  return 0;
}
