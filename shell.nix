{
  pkgs ? import <nixpkgs> { },
  python3 ? pkgs.python3,
}:
pkgs.mkShell {
  packages = [
    pkgs.paraview
    (python3.withPackages (ps: [ ps.imas-paraview ]))
  ];
}
