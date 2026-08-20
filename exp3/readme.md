# Experiment 3 — Valid Arithmetic Expression Recognition

## Title
Program to recognise a valid arithmetic expression that uses operators `+`, `-`, `*` and `/`.

---

## Aim
To write a program using FLEX and BISON that recognises a valid arithmetic expression involving the four basic arithmetic operators.

---

## Algorithm

### FLEX (`art_expr.l`)
1. Include the required header and the BISON-generated token header.
2. Define patterns to return `ID` for identifiers, `DIG` for integers.
3. Pass single characters (operators, parentheses) directly to the parser.
4. Return `0` on newline to signal end of input.

### BISON (`art_expr.y`)
1. Declare tokens `ID` and `DIG`.
2. Set operator associativity: `+` and `-` are left-associative; `*` and `/` are left-associative; unary minus (`UMINUS`) is right-associative with higher precedence.
3. Define grammar:
   - `stmt → expn`
   - `expn → expn op expn | -expn | (expn) | DIG | ID`
4. `main()` calls `yyparse()`.
5. `yyerror()` prints "Invalid Expression" and exits.

---

## Files
| File | Description |
|------|-------------|
| `art_expr.l` | FLEX source — tokeniser |
| `art_expr.y` | BISON source — grammar + actions |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the lexer
flex art_expr.l

# Step 2 — generate the parser (creates art_expr.tab.c and art_expr.tab.h)
bison -d art_expr.y

# Step 3 — compile everything together
gcc lex.yy.c art_expr.tab.c -o art_expr -lfl

# Step 4 — run
./art_expr
```

---

## Expected Output
```
Enter the Expression
a+b*c-d/e
Valid Expression

Enter the Expression
a=b
Invalid Expression
```

---

## Notes
- The `-d` flag in `bison -d` produces the `art_expr.tab.h` header that FLEX needs.
- Operator precedence is enforced by the `%left` / `%right` declarations in the BISON file.

---

## Result
The program to recognise a valid arithmetic expression using FLEX and BISON was executed and verified successfully.
