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
    | x = expr EOL              { Some x }

expr:
    | x = FLOAT                 { x }
    | LPAREN x = expr RPAREN    { x }
    | x = expr ADD y = expr     { x +. y }
    | x = expr SUB y = expr     { x -. y }
    | x = expr MUL y = expr     { x *. y }
    | x = expr DIV y = expr     { x /. y }
    | x = expr POW y = expr     { Float.pow x y }
    | SQRT x = expr             { Float.sqrt x }
    | SUB x = expr %prec MINUS  { -. x }
