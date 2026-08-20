# Experiment 2 — Lexical Analyser (Token Recognition)

## Title
Implement a Lexical Analyser using the LEX tool.

---

## Aim
To create a program that reads a C source file and identifies individual tokens — keywords, identifiers, constants, operators, preprocessor directives, header files and delimiters — using FLEX and regular-expression matching.

---

## Algorithm
1. Define patterns using regular expressions for every token category.
2. Set up a FLEX file with three sections: Definitions, Rules, and User Code.
3. Attach a print action to each pattern.
4. Compile using `flex` and `gcc`.
5. Run the program with a C source file as input.
6. Print each token type as it is matched.
7. Print `End of file` when all tokens are processed.

---

## Files
| File | Description |
|------|-------------|
| `lexer.l` | FLEX source — complete lexical analyser |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the C lexer
flex lexer.l

# Step 2 — compile
gcc lex.yy.c -o lexer -lfl

# Step 3 — create a small C test file
cat > iplex.c << 'EOF'
#include<stdio.h>
void main()
{
    int x;
    x = 10;
}
EOF

# Step 4 — run
./lexer iplex.c
```

---

## Expected Output
```
Preprocessor Directive : #include
Header File            : <stdio.h>
Keyword                : void
Identifier             : main
Delimiter              : (
Delimiter              : )
Delimiter              : {
Keyword                : int
Identifier             : x
Delimiter              : ;
Identifier             : x
Operator               : =
Number                 : 10
Delimiter              : ;
Delimiter              : }

End of file
```

---

## Result
The FLEX program for the implementation of a Lexical Analyser was executed and verified successfully.
