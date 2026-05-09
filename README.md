# Compiler Practical Task #2 - LL(1) Parser and Parse Tree

This repository contains the solution files for Compiler Practical Task #2.

## Files
- `scanner.l` - Flex scanner for id, ^, and ;
- `parser.y` - Bison grammar and parse tree construction
- `node.h` - parse tree node structure
- `tree.dot` - Graphviz DOT file for the parse tree
- `tree.png` - generated parse tree image
- `manual_tree.png` - hand-drawn style parse tree
- `input.txt` - test input string
- `lr0_items.txt` - LR(0) item-set notes
- `result.txt` - sample output
- `Compiler_Task2_Documentation.docx` - full report

## Input String
`id ^ id ^ id ; id ^ id`

## Build commands
```bash
bison -d parser.y
flex scanner.l
gcc parser.tab.c lex.yy.c -o parser
./parser < input.txt
dot -Tpng tree.dot -o tree.png
```
