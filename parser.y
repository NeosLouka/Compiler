%{
#include <stdio.h>
#include "symbol_table.h"

int yylex();
void yyerror(const char *s);
%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%token ASSIGN
%token PLUS MINUS TIMES DIVIDE
%token SEMICOLON
%token LPAREN RPAREN

%type <ival> program stmt_list stmt expr term factor

%left PLUS MINUS
%left TIMES DIVIDE

%%
program:
    stmt_list
    ;

stmt_list:
    stmt_list stmt
    | stmt
    ;

stmt:
    expr SEMICOLON       { printf("%d\n", $1); }
    | IDENTIFIER ASSIGN expr SEMICOLON { sym_lookup($1)->value = $3; free($1); }
    ;

expr:
    expr PLUS term       { $$ = $1 + $3; }
    | expr MINUS term    { $$ = $1 - $3; }
    | term               { $$ = $1; }
    ;

term:
    term TIMES factor    { $$ = $1 * $3; }
    | term DIVIDE factor { $$ = $1 / $3; }
    | factor             { $$ = $1; }
    ;

factor:
    NUMBER               { $$ = $1; }
    | IDENTIFIER         { $$ = sym_lookup($1)->value; free($1); }
    | LPAREN expr RPAREN { $$ = $2; }
    ;
%%

int main(void) {
    int result = yyparse();
    sym_free_all();
    return result;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
