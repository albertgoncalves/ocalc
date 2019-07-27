%token <string> ID
%token <string> STR
%token <string> INT
%token <string> FLOAT
%token SELECT
%token AS
%token FROM
%token LP
%token RP
%token COMMA
%token END
%token EOF

%start <Prelude.sql list> main

%%

main:
    | x = expr END | x = expr EOF       { x }

expr:
    | x = select                        { [x] }
    | x = select y = from               { [x; y] }

select:
    | SELECT x = item_as xs = delim_item_as*
                                        { Prelude.Select
                                            (Prelude.Exprs (x::xs))
                                        }

from:
    | FROM x = ID                       { Prelude.FromTable x }
    | FROM x = sub_expr                 { Prelude.FromExpr x }

item_as:
    | x = item                          { x }
    | x = item AS y = ID                { Prelude.As (x, y) }

delim_item_as:
    | x = delim_item                    { x }
    | x = delim_item AS y = ID          { Prelude.As (x, y) }

item:
    | x = id | x = sub_expr             { x }

sub_expr:
    | LP xs = expr RP                   { Prelude.Inner xs }

delim_item:
    | COMMA x = item                    { x }

id:
    | x = ID                            { Prelude.Id x }
    | x = STR                           { Prelude.Str x }
    | x = INT                           { Prelude.Int x }
    | x = FLOAT                         { Prelude.Float x }
