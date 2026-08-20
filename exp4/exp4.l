%{
#include "valvar.tab.h"
%}

%%
[a-zA-Z]   { return LET; }
[0-9]      { return DIG; }
\n         { return 0; }
.          { /* ignore other characters */ }
%%

int yywrap() {
    return 1;
}
