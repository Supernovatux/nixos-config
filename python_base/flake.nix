{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    let
      forEachSystem =
        f: nixpkgs.lib.genAttrs (import systems) (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      devShells = forEachSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              jupyter
              (python312.withPackages (
                ps: with ps; [
                  ipython
                  pip
                  jupyterlab
                  numpy
                  scipy
                  notebook
                  matplotlib
                  pandas
                ]
              ))
            ];
          };
        }
      );
    };
}
