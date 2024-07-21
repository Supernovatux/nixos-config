{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, chaotic, ... }: {
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.supernovatux = nixpkgs.lib.nixosSystem {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix 
        nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
        chaotic.nixosModules.default 
      ];
    };
  };
}
