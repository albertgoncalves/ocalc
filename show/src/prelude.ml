type expr =
    | Binary of string * expr * expr
    | Unary of string * expr
    | Val of string

let rec print_expr: (expr -> string) = function
    | Val x -> x
    | Binary (f, x, y) ->
        Printf.sprintf "%s(%s, %s)" f (print_expr x) (print_expr y)
    | Unary (f, x) -> Printf.sprintf "%s(%s)" f (print_expr x)
