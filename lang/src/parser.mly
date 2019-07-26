%token <string> ID
%token <string> STR
%token <string> NUM
%token ASSIGN
%token EOL

%right ASSIGN                   /* precedence */

%start <Prelude.expr option> main

%%

main:
    | EOL                       { None }
    | e = expr EOL              { Some e }

expr:
    | x = ID                    { Prelude.Id x }
    | x = NUM                   { Prelude.Num x }
    | x = STR                   { Prelude.Str x }
    | x = expr ASSIGN y = expr  { Prelude.Assign (x, y) }
