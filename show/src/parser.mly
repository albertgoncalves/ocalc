%token <string> FLOAT
%token ADD
%token SUB
%token MUL
%token DIV
%token POW
%token SQRT
%token LPAREN
%token RPAREN
%token EOL

%left ADD SUB               /* lowest precedence */
%left MUL DIV
%left POW %nonassoc SQRT
%nonassoc MINUS             /* highest precedence */

%start <Prelude.expr option> main

%%

main:
    | EOL                       { None }
    | x = expr EOL              { Some x }

expr:
    | x = FLOAT                 { Prelude.Val x }
    | LPAREN; x = expr; RPAREN  { x }
    | x = expr; ADD; y = expr   { Prelude.Binary ("Add", x, y) }
    | x = expr; SUB; y = expr   { Prelude.Binary ("Sub", x, y) }
    | x = expr; MUL; y = expr   { Prelude.Binary ("Mul", x, y) }
    | x = expr; DIV; y = expr   { Prelude.Binary ("Div", x, y) }
    | x = expr; POW; y = expr   { Prelude.Binary ("Pow", x, y) }
    | SQRT x = expr             { Prelude.Unary ("Sqrt", x) }
    | SUB x = expr %prec MINUS  { Prelude.Unary ("Minus", x) }
