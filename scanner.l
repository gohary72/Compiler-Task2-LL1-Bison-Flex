%{
#include "parser.tab.h"
%}

%%
"id"        { return ID; }
"^"         { return POWER; }
";"         { return SEMI; }
[ \t\r\n]+   { /* skip whitespace */ }
.           { return yytext[0]; }
%%

int yywrap(void)
{
    return 1;
}
