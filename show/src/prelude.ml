type expr =
    | Binary of string * expr * expr
    | Unary of string * expr
    | Val of string

let rec string_of_expr : (expr -> string) = function
    | Val x -> x
    | Binary (f, x, y) ->
        Printf.sprintf "%s(%s, %s)" f (string_of_expr x) (string_of_expr y)
    | Unary (f, x) -> Printf.sprintf "%s(%s)" f (string_of_expr x)
