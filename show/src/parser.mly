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
    | EOL                           { None }
    | e = expr EOL                  { Some e }

expr:
    | f = FLOAT                     { Prelude.Val f }
    | LPAREN e = expr RPAREN        { e }
    | e1 = expr ADD e2 = expr       { Prelude.Binary ("Add", e1, e2) }
    | e1 = expr SUB e2 = expr       { Prelude.Binary ("Sub", e1, e2) }
    | e1 = expr MUL e2 = expr       { Prelude.Binary ("Mul", e1, e2) }
    | e1 = expr DIV e2 = expr       { Prelude.Binary ("Div", e1, e2) }
    | e1 = expr POW e2 = expr       { Prelude.Binary ("Pow", e1, e2) }
    | SQRT e = expr                 { Prelude.Unary ("Sqrt", e) }
    | SUB e = expr %prec MINUS      { Prelude.Unary ("Minus", e) }
