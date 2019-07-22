{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "ocalc";
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            findlib
            ocaml
            ocp-indent
            utop
        ])
        rlwrap
    ];
    shellHook = ''
        . .shellhook
    '';
}
