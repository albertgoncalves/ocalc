%token <string> TEXT
%token MARK
%token EOF

%start <(string * string) option list> main

%%

main:
    | xs = row* EOF                 { xs }

row:
    | MARK x = TEXT y = TEXT MARK   { Some (x, y) }
    | TEXT                          { None }
