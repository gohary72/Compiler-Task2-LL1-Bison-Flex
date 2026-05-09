%{
#include <stdio.h>
#include <stdlib.h>
#include "node.h"

int yylex(void);
void yyerror(const char* s);
Node* root = NULL;

static int nodeCounter = 0;

Node* createNode(const char* label, Node* left, Node* right)
{
    Node* n = (Node*) malloc(sizeof(Node));
    n->label = strdup(label);
    n->left = left;
    n->right = right;
    return n;
}

void writeDot(Node* n, FILE* out)
{
    if (n == NULL) return;
    int current = nodeCounter++;
    fprintf(out, "  node%d [label=\"%s\"];\n", current, n->label);

    if (n->left != NULL)
    {
        int child = nodeCounter;
        writeDot(n->left, out);
        fprintf(out, "  node%d -> node%d;\n", current, child);
    }
    if (n->right != NULL)
    {
        int child = nodeCounter;
        writeDot(n->right, out);
        fprintf(out, "  node%d -> node%d;\n", current, child);
    }
}

void exportDot(Node* root, const char* filename)
{
    FILE* out = fopen(filename, "w");
    fprintf(out, "digraph ParseTree {\n");
    fprintf(out, "  node [shape=circle, fontname=\"Arial\"];\n");
    nodeCounter = 0;
    writeDot(root, out);
    fprintf(out, "}\n");
    fclose(out);
}
%}

%union {
    Node* node;
}

%token ID POWER SEMI
%type <node> S Sprime P R

%%
program:
      S              { root = $1; }
    ;

S:
      P Sprime       { $$ = createNode("S", $1, $2); }
    ;

Sprime:
      SEMI P Sprime  { $$ = createNode("S'", createNode(";", NULL, NULL), createNode("P S'", $2, $3)); }
    | /* empty */    { $$ = createNode("epsilon", NULL, NULL); }
    ;

P:
      ID R           { $$ = createNode("P", createNode("id", NULL, NULL), $2); }
    ;

R:
      POWER ID R     { $$ = createNode("R", createNode("^ id", NULL, NULL), $3); }
    | /* empty */    { $$ = createNode("epsilon", NULL, NULL); }
    ;
%%

void yyerror(const char* s)
{
    printf("Parse error: %s\n", s);
}

int main(void)
{
    if (yyparse() == 0)
    {
        printf("Input accepted.\n");
        exportDot(root, "tree.dot");
        printf("tree.dot generated.\n");
    }
    return 0;
}
