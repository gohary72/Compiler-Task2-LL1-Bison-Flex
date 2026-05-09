#ifndef NODE_H
#define NODE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char* label;
    struct Node* left;
    struct Node* right;
} Node;

Node* createNode(const char* label, Node* left, Node* right);
void exportDot(Node* root, const char* filename);

#endif
