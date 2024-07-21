{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    xremap.url = "github:xremap/nix-flake";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, chaotic, xremap, ... }: {
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.supernovatux = nixpkgs.lib.nixosSystem {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      modules = [ 
	xremap.nixosModules.default
        ./configuration.nix 
        nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
        chaotic.nixosModules.default 
      ];
    };
  };
}
