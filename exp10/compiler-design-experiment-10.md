# Experiment 10: Compiler Back-End for 8086 Assembly Generation

**Date:**

## Aim

To implement a compiler back-end that accepts three-address code and generates equivalent 8086 assembly language code using FLEX and BISON.

## Algorithm

1. Tokenize TAC identifiers and operators using FLEX.
2. Parse assignment statements of the form `id = expr;` using BISON.
3. Load the first operand into `AX`.
4. Generate `ADD`, `SUB`, `MUL`, or `DIV` instructions for subsequent operands.
5. Store the result from `AX` into the destination identifier.

## `backend.l`

```lex
%{
#include "backend.tab.h"
#include <string.h>
#include <stdlib.h>
%}
%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
"="|"+"|"-"|"*"|"/"|";" { return yytext[0]; }
[ \t\n]                { /* skip whitespace */ }
%%
int yywrap() { return 1; }
```

## `backend.y`

```yacc
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}
%union { char *str; }
%token <str> ID
%type <str> expr
%left '+' '-'
%left '*' '/'
%%
stmt_list: stmt_list stmt | stmt;
stmt: ID '=' expr ';' { printf("MOV %s, AX\n\n", $1); };

expr: ID          { printf("MOV AX, %s\n", $1); $$ = $1; }
    | expr '+' ID { printf("ADD AX, %s\n", $3); $$ = $3; }
    | expr '-' ID { printf("SUB AX, %s\n", $3); $$ = $3; }
    | expr '*' ID { printf("MUL %s\n", $3); $$ = $3; }
    | expr '/' ID {
        printf("MOV DX, 0\nMOV BX, %s\nDIV BX\n", $3);
        $$ = $3;
    };
%%
int main() {
    printf("Enter TAC statements (end with Ctrl+D):\n");
    yyparse(); return 0;
}
int yyerror(char *s) { printf("Syntax Error: %s\n", s); return 0; }
```

## Compile and Run

```bash
flex backend.l
bison -d backend.y
gcc lex.yy.c backend.tab.c -o backend -lfl
./backend
```

## Sample Input

```text
t1 = a + b;
t2 = t1 - c;
t3 = t2 * d;
t4 = t3 / e;
x = t4;
```

## Output

```asm
MOV AX, a
ADD AX, b
MOV t1, AX

MOV AX, t1
SUB AX, c
MOV t2, AX

MOV AX, t2
MUL d
MOV t3, AX

MOV AX, t3
MOV DX, 0
MOV BX, e
DIV BX
MOV t4, AX

MOV AX, t4
MOV x, AX
```

## Result

Thus, the compiler back-end was implemented using FLEX and BISON to translate three-address code into equivalent 8086 assembly language code.
