with (import <nixpkgs> {});

mkShell {
  buildInputs = [ pandoc pandoc-eqnos gnumake ];
}
