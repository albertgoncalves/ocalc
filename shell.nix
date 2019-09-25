with import <nixpkgs> {};
mkShell {
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            async   #
            cohttp  #
            core    # https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/ads/concurrency.html
            findlib # https://dev.realworldocaml.org/concurrent-programming.html
            lwt4    # https://github.com/pusher/websockets-from-scratch-tutorial
            utop    #
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
