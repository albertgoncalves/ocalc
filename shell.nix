{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "ocalc";
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            findlib
            llvm
            menhir
            ocaml
            ocp-indent
        ])
        rlwrap
    ];
    shellHook = ''
        . .shellhook
    '';
}
