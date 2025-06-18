{
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = (nixpkgs.legacyPackages.${system}.extend self.overlays.default);
    in
    {
      packages.${system} = {
        inherit (pkgs.python3Packages) saxonche imas-python imas-paraview;
        default = self.packages.${system}.imas-paraview;
      };
      overlays.default = final: prev: {
        python3 = prev.python310.override {
          packageOverrides = pfinal: pprev: {
            numpy = pfinal.numpy_1;
            saxonche = pfinal.callPackage ./saxonche.nix { };
            imas-python = pfinal.callPackage ./imas-python.nix { };
            imas-paraview = pfinal.callPackage ./imas-paraview.nix { };
          };
        };
        python3Packages = final.python3.pkgs;
      };
      devShell.${system} =
        with pkgs;
        mkShell {
          packages = [
            paraview
            (python3.withPackages (ps: [ ps.imas-paraview ]))
          ];
        };
    };
}
