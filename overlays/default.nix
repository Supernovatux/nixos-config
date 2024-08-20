{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (
      final: prev: {
	inherit (inputs.tex-latext.legacyPackages.${prev.system})
	  flashprint;
      }
    )
  ];
}

