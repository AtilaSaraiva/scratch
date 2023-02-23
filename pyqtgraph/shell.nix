with (import <nixpkgs> {});
let
  my-python-packages = python-packages: with python-packages; [
    pyqtgraph
    # other python packages you want
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
    libsForQt5.qt5.qtwayland
  ];
}

