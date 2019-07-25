%token <float> FLOAT
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

%start <float option> main

%%

main:
    | EOL                       { None }
    | e = expr EOL              { Some e }

expr:
    | f = FLOAT                 { f }
    | LPAREN e = expr RPAREN    { e }
    | e1 = expr ADD e2 = expr   { e1 +. e2 }
    | e1 = expr SUB e2 = expr   { e1 -. e2 }
    | e1 = expr MUL e2 = expr   { e1 *. e2 }
    | e1 = expr DIV e2 = expr   { e1 /. e2 }
    | e1 = expr POW e2 = expr   { Float.pow e1 e2 }
    | SQRT e = expr             { Float.sqrt e }
    | SUB e = expr %prec MINUS  { -. e }
