%token <float> FLOAT
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token EOL

%left PLUS MINUS        /* lowest precedence  */
%left TIMES DIV         /* medium precedence  */
%nonassoc UMINUS        /* highest precedence */

%start <float> main

%%

main:
    | e = expr EOL                  { e }

expr:
    | i = FLOAT                     { i }
    | LPAREN e = expr RPAREN        { e }
    | e1 = expr PLUS e2 = expr      { e1 +. e2 }
    | e1 = expr MINUS e2 = expr     { e1 -. e2 }
    | e1 = expr TIMES e2 = expr     { e1 *. e2 }
    | e1 = expr DIV e2 = expr       { e1 /. e2 }
    | MINUS e = expr %prec UMINUS   { -. e }
