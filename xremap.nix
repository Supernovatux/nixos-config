{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:

{

  services.xremap = {
    serviceMode = "user";
    userName = "thulashitharan";
    withWlroots = true;
  };
  services.xremap.config.modmap = [
    {
      name = "Global";
      remap = {
        "KEY_RIGHTALT" = "KEY_BACKSPACE";
      }; # globally remap CapsLock to Esc
    }
  ];
}
