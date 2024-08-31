{
  config,
  pkgs,
  lib,
  tex-latext,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (
      final: prev: {
	inherit (tex-latext.legacyPackages.${prev.system})
	  flashprint;
      }
    )
  ];
}

