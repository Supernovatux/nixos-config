{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:

{
  programs.gamemode = {
    enable = true;
    settings.general.inhibit_screensaver = 0;
    enableRenice = true;
  };
  programs.steam.gamescopeSession.args = ["--hdr-enabled" "--hdr-itm-enable" "-W 2560" "-H 1600" "-O eDP-1" ];
  programs.steam.gamescopeSession.enable = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    gamescope-wsi
    vulkan-tools
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    proton-ge-custom
    dxvk
    dxvk_2
    winetricks
    bottles
    vkd3d
  ];
}
