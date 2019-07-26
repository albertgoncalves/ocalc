# ocalc

Trying to figure out how to use `ocamllex` and `menhir`.

#### Tutorials
 * [The OCaml system - Lexer and parser generators (ocamllex, ocamlyacc)](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html)
 * [Real World OCaml - Parsing with OCamllex and Menhir](https://dev.realworldocaml.org/parsing-with-ocamllex-and-menhir.html).

#### Manuals
 * [Module Lexing](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Lexing.html)
 * [Menhir Reference Manual](http://gallium.inria.fr/~fpottier/menhir/manual.html)

#### Examples
 * [calc](https://gitlab.inria.fr/fpottier/menhir/tree/master/demos/calc)
 * [nixformat](https://github.com/d2km/nixformat)

#### Posts
 * [A Nix parser in OCaml. Part 1: Lexer](https://pl-rants.net/posts/nix-parser-in-ocaml-part1/)
 * [A Nix parser in OCaml. Part 2: Parser](https://pl-rants.net/posts/nix-parser-in-ocaml-part2/)

Needed things
---
 * [Nix](https://nixos.org/nix/)

Quick start
---
```
$ nix-shell
```
```
[nix-shell:path/to/ocalc]$ cd calc/
[nix-shell:path/to/ocalc/calc]$ cat script.txt
1 + 1
(6 * -100)
7 ** 3.01
sq 25
((-99 / 100) * 10) / 3

99 / 100 * 10 / 3
99 / (100 * (10 / 3))

1..
[nix-shell:path/to/ocalc/calc]$ cat script.txt | ./main
18 states, 299 transitions, table size 1304 bytes
2.000000
-600.000000
349.739835
5.000000
-3.300000
3.300000
0.297000
Lex error: line 10, offset 2
```
```
[nix-shell:path/to/ocalc]$ cd show/
[nix-shell:path/to/ocalc/show]$ cat ../calc/script.txt | ./main
18 states, 299 transitions, table size 1304 bytes
Add(1, 1)
Mul(6, Minus(100))
Pow(7, 3.01)
Sqrt(25)
Div(Mul(Div(Minus(99), 100), 10), 3)
Div(Mul(Div(99, 100), 10), 3)
Div(99, Mul(100, Div(10, 3)))
Lex error: line 10, offset 2
```
```
[nix-shell:path/to/ocalc]$ cd lang/
[nix-shell:path/to/ocalc/lang]$ cat script.txt
a = 10
.. a = 11
b = "abcdefg"
c = "\""
e = "
    xyz
"
fn f a {
    a = 11
    a = 12
    .. a = 13
}
fn f x y {
    ..
    z = "
        ..
    "
}
[nix-shell:path/to/ocalc/lang]$ cat script.txt | ./main
24 states, 552 transitions, table size 2352 bytes
Assign(Var(a),Num(10))
Assign(Var(b),Str(abcdefg))
Assign(Var(c),Str("))
Assign(Var(e),Str(
    xyz
))
Fn(f)(a)(Assign(Var(a),Num(11)),Assign(Var(a),Num(12)))
Fn(f)(x,y)(Assign(Var(z),Str(
        ..
    )))
```
