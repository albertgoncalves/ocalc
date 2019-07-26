%token <string> VAR
%token <string> STR
%token <string> NUM
%token FN
%token ASSIGN
%token LC
%token RC
%token EOF

%right ASSIGN                               /* precedence */

%start <Prelude.expr list> main

%%

main:
    | xs = expr* EOF                        { xs }

expr:
    | x = VAR                               { Prelude.Var x }
    | x = NUM                               { Prelude.Num x }
    | x = STR                               { Prelude.Str x }
    | x = expr ASSIGN y = expr              { Prelude.Assign (x, y) }
    | FN x = VAR xs = VAR* LC ys = expr* RC { Prelude.Fn (x, xs, ys) }
