%token <float> FLOAT
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token POWER
%token SQRT
%token LPAREN
%token RPAREN
%token EOL

%left PLUS MINUS        /* lowest precedence  */
%left TIMES DIV
%left POWER             /* medium precedence  */
%nonassoc SQRT
%nonassoc UMINUS        /* highest precedence */

%{
    open Prelude
%}

%start <Prelude.result> main

%%

main:
    | EOL                           { Empty }
    | e = expr EOL                  { Value (e) }

expr:
    | f = FLOAT                     { f }
    | LPAREN e = expr RPAREN        { e }
    | e1 = expr PLUS e2 = expr      { e1 +. e2 }
    | e1 = expr MINUS e2 = expr     { e1 -. e2 }
    | e1 = expr TIMES e2 = expr     { e1 *. e2 }
    | e1 = expr DIV e2 = expr       { e1 /. e2 }
    | e1 = expr POWER e2 = expr     { Float.pow e1 e2 }
    | SQRT e = expr                 { Float.sqrt e }
    | MINUS e = expr %prec UMINUS   { -. e }
