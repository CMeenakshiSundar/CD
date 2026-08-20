# Experiment 6 — Calculator using LEX and YACC

## Title
Implementation of a calculator using LEX and YACC (FLEX and BISON).

---

## Aim
To write a program using FLEX and BISON that implements a simple arithmetic calculator supporting `+`, `-`, `*`, `/`, unary minus and parenthesised expressions.

---

## Algorithm
1. In the FLEX file (`cal.l`), define a pattern for integer digits.
2. When a number is matched, convert it with `atof()`, store in `yylval` and return `NUM`.
3. Pass all other single characters (operators, parentheses, newline) directly to BISON.
4. In the BISON file (`cal.y`), define grammar rules for arithmetic expressions with correct operator precedence using `%left` and `%right`.
5. Each rule computes a result stored in `$$` using the semantic values `$1`, `$2`, `$3` …
6. Print the result after evaluating a complete expression.
7. Report a parse error if the input does not match the grammar.

---

## Files
| File | Description |
|------|-------------|
| `cal.l` | FLEX source — tokenises numbers and operators |
| `cal.y` | BISON source — arithmetic grammar + evaluation |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the lexer
flex cal.l

# Step 2 — generate the parser
bison -d cal.y

# Step 3 — compile
gcc lex.yy.c cal.tab.c -o calc -lfl

# Step 4 — run
./calc
```

---

## Expected Output
```
Enter the expression:
2+2
Answer: 4

Enter the expression:
10*3-5/5
Answer: 29

Enter the expression:
(4+6)*2
Answer: 20
```

---

## Notes
- The `%option noyywrap` directive in `cal.l` replaces the need for a `yywrap()` function.
- The `YYSTYPE double` definition allows the calculator to work with floating-point numbers even when integer tokens are entered.
- Operator precedence order (low → high): `+`/`-` → `*`/`/` → unary minus.

---

## Result
The program for implementing a calculator using FLEX and BISON was executed and verified successfully.
