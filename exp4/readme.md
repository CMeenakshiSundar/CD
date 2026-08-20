# Experiment 4 — Valid Variable Recognition

## Title
Program to recognise a valid variable — starts with a letter followed by any number of letters or digits.

---

## Aim
To write a program using FLEX and BISON that recognises whether a given string is a valid C-style variable name (must begin with a letter, followed by any mix of letters and digits).

---

## Algorithm

### FLEX (`valvar.l`)
1. Return token `LET` when a single letter `[a-zA-Z]` is matched.
2. Return token `DIG` when a single digit `[0-9]` is matched.
3. Return `0` on newline to signal end of input.

### BISON (`valvar.y`)
1. Declare tokens `LET` and `DIG`.
2. Define grammar:
   - `variable → var`
   - `var → var DIG | var LET | LET`  (must start with a letter)
3. `main()` prints a prompt and calls `yyparse()`.
4. `yyerror()` prints "Invalid variable" and exits.

---

## Files
| File | Description |
|------|-------------|
| `valvar.l` | FLEX source — returns LET / DIG tokens |
| `valvar.y` | BISON source — grammar for valid variable |
| `output.txt` | Sample terminal output |

---

## Compile & Run

```bash
# Step 1 — generate the lexer
flex valvar.l

# Step 2 — generate the parser
bison -d valvar.y

# Step 3 — compile
gcc lex.yy.c valvar.tab.c -o valvar -lfl

# Step 4 — run
./valvar
```

---

## Expected Output
```
Enter the variable:
add
Valid variable

Enter the variable:
add1
Valid variable

Enter the variable:
1add
Invalid variable
```

---

## Notes
- The grammar rule `var : LET` ensures the first character must always be a letter.
- Subsequent characters can be either letters (`LET`) or digits (`DIG`).

---

## Result
The program to recognise a valid variable name using FLEX and BISON was executed and verified successfully.
