# ocalc

Trying to figure out how to use `ocamllex`, `ocamlyacc`, and `menhir`.
 * [The OCaml system - Chapter 13](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html)
 * [Real World OCaml - Parsing with OCamllex and Menhir](https://dev.realworldocaml.org/parsing-with-ocamllex-and-menhir.html).
 * [Menhir Reference Manual](http://gallium.inria.fr/~fpottier/menhir/manual.html)
 * [calc-incremental](https://gitlab.inria.fr/fpottier/menhir/tree/master/demos/calc-incremental)
 * [MenhirLib.IncrementalEngine](https://gitlab.inria.fr/fpottier/menhir/blob/master/src/IncrementalEngine.ml)
 * [Module Lexing](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Lexing.html)
 * [A Nix parser in OCaml. Part 1: Lexer](https://pl-rants.net/posts/nix-parser-in-ocaml-part1/)
 * [A Nix parser in OCaml. Part 2: Parser](https://pl-rants.net/posts/nix-parser-in-ocaml-part2/)
 * [nixformat](https://github.com/d2km/nixformat)

Needed things
---
 * [Nix](https://nixos.org/nix/)

Quick start
---
```
$ nix-shell
```
```
[nix-shell:path/to/ocalc]$ cat calc.txt
1 + 1
(6 * 100)
100 - 9.01
((99 / 100) * 10) / 3
(99 / 100) * (10 / 3)
(99 / 100) * 10 / 3
99 / 100 * 10 / 3
99 / 100 * (10 / 3)
99 / (100 * (10 / 3))
```
```
[nix-shell:path/to/ocalc]$ cat calc.txt | ./main
Read 11 sample input sentences and 11 error messages.
Finished, 14 targets (14 cached) in 00:00:00.
2.000000
600.000000
90.990000
3.300000
3.300000
3.300000
3.300000
3.300000
0.297000
```
