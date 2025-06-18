{
  pkgs ? import <nixpkgs> { },
  python3 ? pkgs.python3Full,
}:
let
  py = python3.override {
    packageOverrides = final: prev: {
      saxonche = final.callPackage ./saxonche.nix { };
      imas-python = final.callPackage ./imas-python.nix { };
      imas-paraview = final.callPackage ./imas-paraview.nix { };
    };
  };
in
pkgs.mkShell {
  packages = [
    pkgs.paraview
    (py.withPackages (ps: [ ps.imas-paraview ]))
  ];
}
