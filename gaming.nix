{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:

{
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
  programs.gamemode = {
    enable = true;
    settings.general.inhibit_screensaver = 0;
    enableRenice = true;
  };
  programs.steam.gamescopeSession.args = [
    "--hdr-enabled"
    "--hdr-itm-enable"
    "-W 2560"
    "-H 1600"
    "-O eDP-1"
  ];
  programs.steam.gamescopeSession.enable = true;
  programs.steam.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
    ];
  };
  environment.systemPackages = with pkgs; [
    gamescope-wsi
    vulkan-tools
    wineWowPackages.unstableFull
    dxvk
    xorg.xinit
    dxvk_2
    winetricks
    bottles
    vkd3d
  ];
  users.users.thulashitharan = {
    packages = with pkgs; [
      openttd
    ];
  };
}
