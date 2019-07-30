%token START
%token END
%token EOF
%token <string> NAME
%token <string> COORDINATES

%start <(string * string) option list> main

%%

main:
    | xs = row* EOF                         { xs }

row:
    | START x = NAME y = COORDINATES END    { Some (x, y) }
    | NAME                                  { None }
