{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.mkShell {
  packages = with pkgs; [
    simdb
    paraview
    imas-paraview
  ];
}
