with import <nixpkgs> {};
mkShell {
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            menhir
            ocaml
            ocp-indent
        ])
        rlwrap
        shellcheck
    ];
    shellHook = ''
        . .shellhook
    '';
}
