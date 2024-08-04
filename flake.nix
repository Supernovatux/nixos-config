{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    xremap.url = "github:xremap/nix-flake";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-matlab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
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
      nix-matlab,
      ...
    }:
      let
    flake-overlays = [
      nix-matlab.overlay
    ];
  in {
      # NOTE: 'nixos' is the default hostname set by the installer
      nixosConfigurations.supernovatux = nixpkgs.lib.nixosSystem {
        # NOTE: Change this to aarch64-linux if you are on ARM
        system = "x86_64-linux";
        modules = [
          lanzaboote.nixosModules.lanzaboote
          xremap.nixosModules.default
          (import ./configuration.nix
	    flake-overlays
	  )
          nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
          chaotic.nixosModules.default
        ];
      };
    };
}
