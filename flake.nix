{
  description = "Overlay to add various IMAS tools to nixpkg Python packages.";
  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        }
      );
    in
    {
      overlays.default = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pfinal: pprev: {
            sqlalchemy = pprev.sqlalchemy.overrideAttrs rec {
              version = "1.4.54";
              src = pfinal.fetchPypi {
                inherit (pprev.sqlalchemy) pname;
                inherit version;
                hash = "sha256-RHD77QiMNdwgt4o5qvSuVP6BeQx4OzJkhyoCJPQ3wxo=";
              };
              disabledTestPaths = [
                # typing correctness, not interesting
                "test/ext/mypy"
                # slow and high memory usage, not interesting
                "test/aaa_profiling"
              ];
            };
            imas-core = pfinal.callPackage ./imas-core.nix { };
            imas-data-dictionaries = pfinal.callPackage ./imas-data-dictionaries.nix { };
            imas-python = pfinal.callPackage ./imas-python.nix { };
            imas-simdb = pfinal.callPackage ./imas-simdb.nix { };
            imas-paraview = pfinal.callPackage ./imas-paraview.nix { };
          })
        ];
        simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
        imas-paraview = final.python3Packages.toPythonApplication final.python3.pkgs.imas-paraview;
      };
      packages = forAllSystems (system: {
        inherit (pkgs.${system}) simdb imas-paraview;
        default = self.packages.${system}.simdb;
      });
      apps = forAllSystems (system: {
        simdb = {
          type = "app";
          program = "${self.packages.${system}.simdb}/bin/simdb";
          description = "SimDB CLI";
        };
        default = self.apps.${system}.simdb;
      });
      devShells = forAllSystems (system: {
        default =
          let
            python3 = pkgs.${system}.python3;
            imas-paraview = python3.pkgs.imas-paraview;
          in
          pkgs.${system}.mkShellNoCC {
            env.PV_PLUGIN_PATH = "${imas-paraview}/lib/python${python3.pythonVersion}/site-packages/imas_paraview/plugins";
            packages = [
              pkgs.${system}.simdb
              pkgs.${system}.paraview
              (python3.pkgs.toPythonApplication imas-paraview)
            ];
          };
      });
    };
}
