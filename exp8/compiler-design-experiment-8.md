# Experiment 8: Type Checking Using LEX and YACC

**Date:**

## Aim

To implement type checking for simple declarations and expressions using FLEX, BISON, and a symbol table.

## Algorithm

1. Tokenize `int`, `float`, identifiers, numbers, and operators using FLEX.
2. Insert declared variable names and types into a symbol table.
3. Look up operand and destination types while parsing assignments.
4. Report undefined variables or type mismatches; otherwise confirm type consistency.

## `typecheck.l`

```lex
%{
#include "typecheck.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"int"                       { return INT; }
"float"                     { return FLOAT; }
[a-zA-Z_][a-zA-Z0-9_]*      { yylval.str = strdup(yytext); return ID; }
[0-9]+                       { yylval.str = strdup(yytext); return NUM; }
"="|"+"|"-"|"*"|"/"|";"   { return yytext[0]; }
[ \t\n]                      { /* skip whitespace */ }
%%

int yywrap() { return 1; }
```

## `typecheck.y`

```yacc
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct sym { char name[20]; char type[10]; } table[50];
int n = 0;

void insert(char *name, char *type) {
    strcpy(table[n].name, name);
    strcpy(table[n].type, type);
    n++;
}

char *typeOf(char *name) {
    for (int i = 0; i < n; i++)
        if (strcmp(table[i].name, name) == 0) return table[i].type;
    return "undefined";
}
%}

%union { char *str; }
%token <str> ID NUM
%token INT FLOAT
%type <str> expr

%%
program: stmts;
stmts: stmts stmt | stmt;
stmt: decl | assign;

decl: INT ID ';'   { insert($2, "int"); }
    | FLOAT ID ';' { insert($2, "float"); };

assign: ID '=' expr ';' {
    char *lt = typeOf($1);
    if (strcmp(lt, "undefined") == 0)
        printf("Undefined variable: %s\n", $1);
    else if (strcmp(lt, $3) == 0)
        printf("No type mismatch in expression: %s = ...\n", $1);
    else
        printf("Type mismatch in assignment to %s\n", $1);
};

expr: ID {
        char *t = typeOf($1);
        if (strcmp(t, "undefined") == 0)
            printf("Undefined variable: %s\n", $1);
        $$ = t;
    }
    | NUM             { $$ = "int"; }
    | expr '+' expr   { $$ = strcmp($1, $3) == 0 ? $1 : "mismatch"; }
    | expr '-' expr   { $$ = strcmp($1, $3) == 0 ? $1 : "mismatch"; }
    | expr '*' expr   { $$ = strcmp($1, $3) == 0 ? $1 : "mismatch"; }
    | expr '/' expr   { $$ = strcmp($1, $3) == 0 ? $1 : "mismatch"; };
%%

int main() {
    printf("Enter declarations and expressions:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}
```

## Compile and Run

```bash
flex typecheck.l
bison -d typecheck.y
gcc lex.yy.c typecheck.tab.c -o typecheck -lfl
./typecheck
```

## Sample Output

```text
int a; int b; int c;
a = b * c;
No type mismatch in expression: a = ...

int a; float b; int c;
a = b + c;
Type mismatch in assignment to a
```

## Result

Thus, type checking was implemented successfully using a symbol table, FLEX, and BISON.
