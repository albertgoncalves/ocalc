%token <float> FLOAT
%token PLUS MINUS TIMES DIV
%token LEFTPAREN RIGHTPAREN
%token EOL
%left PLUS MINUS            /* lowest precedence  */
%left TIMES DIV             /* medium precedence  */
%nonassoc UMINUS            /* highest precedence */
%start main                 /* the entry point    */
%type <float> main

%%

main:
    | expr EOL                  { $1 }
    ;

expr:
    | FLOAT                     { $1 }
    | LEFTPAREN expr RIGHTPAREN { $2 }
    | expr PLUS expr            { $1 +. $3 }
    | expr MINUS expr           { $1 -. $3 }
    | expr TIMES expr           { $1 *. $3 }
    | expr DIV expr             { $1 /. $3 }
    | MINUS expr %prec UMINUS   { -. $2 }
    | FLOAT FLOAT               { raise Exceptions.ParseError }
    ;
