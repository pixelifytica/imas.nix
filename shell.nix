{
  pkgs ? import <nixpkgs> { },
  python3 ? pkgs.python3,
  ...
}:
pkgs.mkShell {
  env.PV_PLUGIN_PATH = "${python3.pkgs.imas-paraview}/lib/python${python3.pythonVersion}/site-packages/imas_paraview/plugins";
  packages = [
    pkgs.simdb
    pkgs.paraview
    (python3.withPackages (ps: [ ps.imas-paraview ]))
  ];
}
