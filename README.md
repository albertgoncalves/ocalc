# ocalc

Trying to figure out how to use `ocamllex`, `ocamlyacc`, and `menhir`.
 * [The OCaml system - Chapter 13](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html)
 * [Real World OCaml - Parsing with OCamllex and Menhir](https://dev.realworldocaml.org/parsing-with-ocamllex-and-menhir.html).
 * [Menhir Reference Manual](http://gallium.inria.fr/~fpottier/menhir/manual.html)
 * [calc-incremental](https://gitlab.inria.fr/fpottier/menhir/tree/master/demos/calc-incremental)
 * [MenhirLib.IncrementalEngine](https://gitlab.inria.fr/fpottier/menhir/blob/master/src/IncrementalEngine.ml)
 * [Module Lexing](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Lexing.html)

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
```
```
[nix-shell:path/to/ocalc]$ cat calc.txt | ./main
11 states, 269 transitions, table size 1142 bytes
./bin/main
2.
600.
90.99
3.3
```
