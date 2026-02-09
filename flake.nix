{
  description = "Overlay to add various IMAS tools to nixpkg Python packages.";
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      supportedPythons = [
        "python311"
        "python312"
        "python313"
      ];
      pkgs = (nixpkgs.legacyPackages.${system}.extend self.overlays.default);
    in
    {
      packages.${system} =
        (builtins.listToAttrs (
          builtins.concatMap (
            python:
            (builtins.map
              (module: {
                name = "${pkgs.${python}.libPrefix}-${module}";
                value = pkgs.${python}.pkgs.${module};
              })
              [
                "imas-core"
                "imas-data-dictionaries"
                "imas-python"
                "imas-simdb"
                "imas-paraview"
              ]
            )
          ) supportedPythons
        ))
        // {
          inherit (pkgs) simdb imas-paraview;
          default = self.packages.${system}.simdb;
        };
      apps.${system} = {
        simdb = {
          type = "app";
          program = "${self.packages.${system}.simdb}/bin/simdb";
          description = "SimDB CLI";
        };
        default = self.apps.${system}.simdb;
      };
      overlays.default =
        final: prev:
        {
          simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
          imas-paraview = final.python3Packages.toPythonApplication final.python3.pkgs.imas-paraview;
        }
        // (builtins.listToAttrs (
          builtins.map (name: {
            inherit name;
            value = prev.${name}.override {
              packageOverrides = pfinal: pprev: {
                imas-core = pfinal.callPackage ./imas-core.nix { };
                imas-data-dictionaries = pfinal.callPackage ./imas-data-dictionaries.nix { };
                imas-python = pfinal.callPackage ./imas-python.nix { };
                imas-simdb = pfinal.callPackage ./imas-simdb.nix { };
                imas-paraview = pfinal.callPackage ./imas-paraview.nix { };
              };
            };
          }) supportedPythons
        ));
      devShells.${system}.default = pkgs.mkShellNoCC {
        env.PV_PLUGIN_PATH = "${pkgs.python3.pkgs.imas-paraview}/lib/python${pkgs.python3.pythonVersion}/site-packages/imas_paraview/plugins";
        packages = with pkgs; [
          simdb
          imas-paraview
          paraview
        ];
      };
    };
}
