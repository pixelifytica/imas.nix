{
  pkgs ? (import <nixpkgs> { }),
}:
let
  python = pkgs.python310Full.override {
    packageOverrides = final: prev: {
      saxonche = final.callPackage ./saxonche.nix { };
      imas-python = final.callPackage ./imas-python.nix { };
      imas-paraview = final.callPackage ./imas-paraview.nix { };
    };
  };
  pythonEnv = python.withPackages (ps: with ps; [ imas-paraview ]);
in
pkgs.mkShell {
  packages = with pkgs; [
    paraview
    pythonEnv
  ];
}
