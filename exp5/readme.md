# Experiment 5 — Control Structure Syntax Recognition

## Title
Program to recognise valid control-structure syntax of C — `for`, `while`, `if-else`, `if-else-if`, `switch-case`, etc.

---

## Aim
To write a program using FLEX and BISON that recognises whether a given snippet of C code represents valid control-structure syntax.

---

## Algorithm

### FLEX (`control.l`)
1. Return keyword tokens: `IF`, `ELSE`, `FOR`, `WHILE`, `SWITCH`, `CASE`, `DEFAULT`.
2. Return `ID` for identifiers and `NUM` for integer literals.
3. Return punctuation tokens: `LBRACE`, `RBRACE`, `LPAREN`, `RPAREN`, `COLON`, `SEMICOLON`.
4. Return relational-operator tokens: `EQ`, `LE`, `GE`, `LT`, `GT`, `ASSIGN`.

### BISON (`control.y`)
1. Define grammar rules for:
   - `if` statement (with and without `else`)
   - `while` loop
   - `for` loop
   - `switch`-`case` structure
2. A `cond` rule represents a simple relational condition `ID relop NUM`.
3. `main()` reads one control-structure snippet and calls `yyparse()`.
4. `yyerror()` prints "Invalid control structure syntax."

---

## Files
| File | Description |
|------|-------------|
| `control.l` | FLEX source — tokeniser |
| `control.y` | BISON source — control-structure grammar |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the lexer
flex control.l

# Step 2 — generate the parser
bison -d control.y

# Step 3 — compile
gcc lex.yy.c control.tab.c -o control -lfl

# Step 4 — run
./control
```

---

## Sample Inputs to Try

```
if (x < 5) { y = 10; }
while (x <= 10) { x = x + 1; }
for (i = 0; i < 10; i = i + 1) { x = x + 1; }
switch (x) { case 1: y = 10; default: y = 0; }
```

---

## Expected Output
```
Enter a C control structure syntax:
if (x < 5) { y = 10; }
Valid control structure syntax.
```

---

## Notes
- The grammar accepts a simplified form of control structures (conditions are `ID relop NUM`).
- The `stmt` rule is intentionally simplified — it accepts only other control structures, not assignment statements, to keep the grammar focused.

---

## Result
The program to recognise valid control-structure syntax of C using FLEX and BISON was executed and verified successfully.
