{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-matlab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      chaotic,
      xremap,
      lanzaboote,
      nix-gaming,
      nix-matlab,
      ...
    }:
    let
      flake-overlays = [ nix-matlab.overlay ];
    in
    {
      # NOTE: 'nixos' is the default hostname set by the installer
      nixosConfigurations.supernovatux = nixpkgs.lib.nixosSystem {
        # NOTE: Change this to aarch64-linux if you are on ARM
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          # tex-latext = import tex-latext {
          #   config.allowUnfree = true;
          #   localSystem = {
          #     system = "x86_64-linux";
          #   };
          # };
        };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          xremap.nixosModules.default
          (import ./configuration.nix flake-overlays)
          nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
          chaotic.nixosModules.default
          (import ./overlays)
        ];
      };
    };
}
