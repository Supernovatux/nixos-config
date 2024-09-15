# ./overlays/default.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    # (final: prev: {
    #   hyprlandPlugins = prev.hyprlandPlugins // {
    #     hyprspace = prev.hyprlandPlugins.hyprspace.overrideAttrs (old: {
    #       src = final.fetchFromGitHub {
    #         owner = "myamusashi";
    #         repo = "Hyprspace";
    #         rev = "08bfc22d75acf5e3ef93ad47252930bb7f555910";
    #         sha256 = "sha256-w0j/3OeSrpx+S8if1M2ONBsZvJQ1hBQkdTQEiMCHy7o=";
    #       };
    #       patches = [ ];
    #     });
    #   };
    # })
    #    (
    #      final: prev: {
    # inherit (inputs.tex-latext.legacyPackages.${prev.system})
    #   texpresso tectonic-unwrapped;
    #      }
    #    )
  ];
}
