# Experiment 1 — Lexical Analyser with Symbol Table

## Title
Using the LEX tool, develop a lexical analyser to recognise patterns in C (identifiers, constants, comments, operators) and create a symbol table while recognising identifiers.

---

## Aim
To develop a lexical analyser using FLEX that recognises tokens such as identifiers, constants, comments and operators in a C program, and to build a symbol table for all identifiers found.

---

## Algorithm
1. Include necessary headers inside the FLEX definitions section.
2. Define regular expressions for:
   - **Identifiers** — `[a-zA-Z_][a-zA-Z0-9_]*`
   - **Constants** — `[0-9]+`
   - **Comments** — `//.*` and `/* … */`
   - **Operators** — `+  -  *  /  =  <  >`
3. Declare a symbol table array with `name` and `type` fields.
4. In the FLEX rules section:
   - On matching an identifier, call `insert()` to add it if absent.
   - Print constants, operators and comments with their category labels.
5. In `main()`, open the input file, call `yylex()`, then print the symbol table.
6. Compile and run (see commands below).

---

## Files
| File | Description |
|------|-------------|
| `symtab.l` | FLEX source — token rules + symbol table logic |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the C lexer
flex symtab.l

# Step 2 — compile
gcc lex.yy.c -o symtab -lfl

# Step 3 — create a small C test file
cat > input.c << 'EOF'
int a = 10; // sum variable
b = a + 5;
EOF

# Step 4 — run
./symtab input.c
```

---

## Expected Output
```
Comment    : // sum variable
Identifier : int
Identifier : a
Constant   : 10
Operator   : =
Identifier : b
Identifier : a
Operator   : +
Constant   : 5

SYMBOL TABLE
S.No    Name
1       int
2       a
3       b
```

---

## Result
The FLEX program to develop a lexical analyser recognising identifiers, constants, comments and operators, and to build a symbol table, was executed and verified successfully.
