# Experiment 7: Generate Three-Address Code Using LEX and YACC

**Date:**

## Aim

To generate three-address code (TAC) for a simple arithmetic expression using FLEX and BISON.

## Algorithm

1. FLEX recognizes identifiers, numbers, and operators and passes their tokens to BISON.
2. BISON parses assignment and arithmetic expressions using operator precedence.
3. Each intermediate result is stored in a temporary variable such as `t1` or `t2`.
4. The generated TAC instructions are printed in evaluation order.

## `tac.l`

```lex
%{
#include "tac.tab.h"
#include <string.h>
%}

%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
[0-9]+                  { yylval.str = strdup(yytext); return NUM; }
[\t\n ]+                { /* skip spaces */ }
.                       { return yytext[0]; }
%%

int yywrap() { return 1; }
```

## `tac.y`

```yacc
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int tempCount = 1;
char temp[10];
%}

%union { char *str; }
%token <str> ID NUM
%type <str> expr
%left '+' '-'
%left '*' '/'

%%
stmt: ID '=' expr { printf("%s = %s\n", $1, $3); };

expr: expr '+' expr {
        sprintf(temp, "t%d", tempCount++);
        printf("%s = %s + %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
    | expr '-' expr {
        sprintf(temp, "t%d", tempCount++);
        printf("%s = %s - %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
    | expr '*' expr {
        sprintf(temp, "t%d", tempCount++);
        printf("%s = %s * %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
    | expr '/' expr {
        sprintf(temp, "t%d", tempCount++);
        printf("%s = %s / %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
    | ID  { $$ = $1; }
    | NUM { $$ = $1; };
%%

int main() {
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
```

## Compile and Run

```bash
flex tac.l
bison -d tac.y
gcc tac.tab.c lex.yy.c -o tac -lfl
./tac
```

## Sample Input

```text
a = b + c * d
```

## Output

```text
t1 = c * d
t2 = b + t1
a = t2
```

## Result

Thus, the program to generate three-address code using FLEX and BISON was executed and verified successfully.
