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
[nix-shell:path/to/ocalc]$ cd calc/
```
```
[nix-shell:path/to/ocalc/calc]$ cat calc.txt
1 + 1
(6 * 100)
7 ** 3.01
| 25
((99 / 100) * 10) / 3

99 / 100 * 10 / 3
99 / (100 * (10 / 3))

1..
```
```
[nix-shell:path/to/ocalc/calc]$ cat calc.txt | ./main
17 states, 299 transitions, table size 1298 bytes
2.000000
600.000000
349.739835
5.000000
3.300000
3.300000
0.297000
Line 10, offset 2: Lexer error
```
