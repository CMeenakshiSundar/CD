%{
#include <stdio.h>
#include "art_expr.tab.h"
%}

%%
[a-zA-Z][0-9a-zA-Z]*   { return ID; }
[0-9]+                  { return DIG; }
[ \t]+                  { /* skip whitespace */ }
\n                      { return 0; }
.                       { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
