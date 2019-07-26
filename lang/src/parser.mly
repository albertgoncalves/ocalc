%token <string> ID
%token <string> STR
%token <string> NUM
%token FN
%token ASSIGN
%token LC
%token RC
%token END
%token EOF

%start <Prelude.expr list> main

%%

main:
    | xs = expr* EOF                        { xs }

expr:
    | x = ID                                { Prelude.Id x }
    | x = NUM                               { Prelude.Num x }
    | x = STR                               { Prelude.Str x }
    | x = expr ASSIGN y = expr END          { Prelude.Assign (x, y) }
    | FN x = ID xs = ID* LC ys = expr* RC   { Prelude.Fn (x, xs, ys) }
