# Experiment 9: Simple Code Optimization

**Date:**

## Aim

To implement constant folding, strength reduction, and algebraic simplification using FLEX and BISON.

## Optimizations

- Constant folding: `2 + 4` becomes `6`.
- Algebraic simplification: `x + 0`, `x - 0`, `x * 1`, and `x / 1` become `x`.
- Strength reduction: `x * 2` becomes `x + x`.

## `optimize.l`

```lex
%{
#include "optimize.tab.h"
#include <string.h>
#include <stdlib.h>
%}
%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
[0-9]+                { yylval.str = strdup(yytext); return NUM; }
"="|"+"|"-"|"*"|"/"|";" { return yytext[0]; }
[ \t\n]                { /* skip whitespace */ }
%%
int yywrap() { return 1; }
```

## `optimize.y`

```yacc
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
%}
%union { char *str; }
%token <str> ID NUM
%type <str> expr
%left '+' '-'
%left '*' '/'
%%
stmt_list: stmt_list stmt | stmt;
stmt: ID '=' expr ';' { printf("%s = %s\n", $1, $3); };

expr: NUM { $$ = $1; }
    | ID  { $$ = $1; }
    | expr '+' expr {
        if (isdigit($1[0]) && isdigit($3[0])) {
            char b[20]; sprintf(b, "%d", atoi($1) + atoi($3)); $$ = strdup(b);
            printf("// Constant Folding: %s+%s -> %s\n", $1, $3, $$);
        } else if (!strcmp($3, "0")) $$ = $1;
        else if (!strcmp($1, "0")) $$ = $3;
        else { char b[40]; sprintf(b, "%s + %s", $1, $3); $$ = strdup(b); }
    }
    | expr '-' expr {
        if (isdigit($1[0]) && isdigit($3[0])) {
            char b[20]; sprintf(b, "%d", atoi($1) - atoi($3)); $$ = strdup(b);
        } else if (!strcmp($3, "0")) $$ = $1;
        else { char b[40]; sprintf(b, "%s - %s", $1, $3); $$ = strdup(b); }
    }
    | expr '*' expr {
        if (isdigit($1[0]) && isdigit($3[0])) {
            char b[20]; sprintf(b, "%d", atoi($1) * atoi($3)); $$ = strdup(b);
        } else if (!strcmp($3, "1")) {
            $$ = $1; printf("// Algebraic Simplification: x*1 -> x\n");
        } else if (!strcmp($3, "2")) {
            char b[40]; sprintf(b, "%s + %s", $1, $1); $$ = strdup(b);
            printf("// Strength Reduction: x*2 -> x+x\n");
        } else { char b[40]; sprintf(b, "%s * %s", $1, $3); $$ = strdup(b); }
    }
    | expr '/' expr {
        if (isdigit($1[0]) && isdigit($3[0])) {
            char b[20]; sprintf(b, "%d", atoi($1) / atoi($3)); $$ = strdup(b);
        } else if (!strcmp($3, "1")) $$ = $1;
        else { char b[40]; sprintf(b, "%s / %s", $1, $3); $$ = strdup(b); }
    };
%%
int main() {
    printf("Enter Three Address Code statements (end with Ctrl+D):\n");
    yyparse(); return 0;
}
int yyerror(char *s) { printf("Syntax Error: %s\n", s); return 0; }
```

## Compile and Run

```bash
flex optimize.l
bison -d optimize.y
gcc lex.yy.c optimize.tab.c -o optimize -lfl
./optimize
```

## Sample Input and Output

```text
a = 2 + 4;
// Constant Folding: 2+4 -> 6
a = 6
b = d * 1;
// Algebraic Simplification: x*1 -> x
b = d
c = s * 2;
// Strength Reduction: x*2 -> x+x
c = s + s
```

## Result

Thus, constant folding, strength reduction, and algebraic simplification were successfully implemented and tested.
