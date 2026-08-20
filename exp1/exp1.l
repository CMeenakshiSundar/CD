%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Symbol table structure */
struct symtab {
    char name[30];
    int  type;
} symtab[100];

int sc = 0;   /* symbol count */

/* Return index if name already exists, else -1 */
int lookup(char *s) {
    int i;
    for (i = 0; i < sc; i++)
        if (strcmp(symtab[i].name, s) == 0)
            return i;
    return -1;
}

/* Insert name into symbol table if not already present */
void insert(char *s) {
    if (lookup(s) == -1) {
        strcpy(symtab[sc].name, s);
        symtab[sc].type = 1;
        sc++;
    }
}
%}

DIGIT [0-9]
ID    [a-zA-Z_][a-zA-Z0-9_]*

%%

"/*"([^*]|\*+[^*/])*\*+"/"   { printf("Comment    : %s\n", yytext); }
"//".*                         { printf("Comment    : %s\n", yytext); }
{ID}                           { insert(yytext); printf("Identifier : %s\n", yytext); }
{DIGIT}+                       { printf("Constant   : %s\n", yytext); }
"+"|"-"|"*"|"/"|"="|"<"|">"   { printf("Operator   : %s\n", yytext); }
[ \t\n]                        { /* skip whitespace */ }
.                              { /* ignore other characters */ }

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Cannot open file: %s\n", argv[1]);
        return 1;
    }

    yylex();

    /* Print symbol table */
    printf("\nSYMBOL TABLE\n");
    printf("S.No\tName\n");
    int i;
    for (i = 0; i < sc; i++)
        printf("%d\t%s\n", i + 1, symtab[i].name);

    fclose(yyin);
    return 0;
}
