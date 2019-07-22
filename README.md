# ocalc

Trying to figure out how to use `ocamllex` and `ocamlyacc`, starting with
[Chapter 13](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html).

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
./bin/calc
2.
600.
90.99
3.3
```
