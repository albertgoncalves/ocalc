%token MARK
%token EOF
%token <string> TEXT

%start <(string * string) option list> main

%%

main:
    | xs = row* EOF                 { xs }

row:
    | MARK x = TEXT y = TEXT MARK   { Some (x, y) }
    | TEXT                          { None }
