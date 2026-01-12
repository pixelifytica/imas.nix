{
  description = "Overlay to add various IMAS tools to nixpkg Python packages.";
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      supportedPython = [
        "python311"
        "python312"
        "python313"
      ];
      pkgs = (nixpkgs.legacyPackages.${system}.extend self.overlays.default);
    in
    {
      packages.${system} = {
        inherit (pkgs) simdb;
        default = self.packages.${system}.simdb;
      };
      overlays.default =
        final: prev:
        {
          simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
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
          }) supportedPython
        ));
      devShells.${system}.default = pkgs.callPackage ./shell.nix { };
    };
}
