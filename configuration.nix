# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
flake-overlays:

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./tex.nix
    ./gaming.nix
    ./xremap.nix
  ];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  virtualisation.spiceUSBRedirection.enable = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  hardware.opengl = {
    enable = true;
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.sane.brscan4.enable = true;
  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
    pkgs.sane-airscan
  ];
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  services.ipp-usb.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    python3
    git
  ];
  security.pam.services.hyprlock = { };
  qt.platformTheme = "gnome";
  hardware.sane.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.getty.autologinUser = "thulashitharan";
  services.upower.enable = true;
  services.logind.lidSwitchExternalPower = "ignore";

  networking.hostName = "supernovatux"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  services.cloudflare-warp.enable = true;
  programs.hyprland.enable = true;
  time.hardwareClockInLocalTime = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.theme = "catppuccin-sddm ";
  services.displayManager.sddm.package = pkgs.kdePackages.sddm;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  programs.kdeconnect.enable = true;
  programs.seahorse.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  systemd.services.setprofileperm = {
    path = with pkgs; [
      bash # adds all binaries from the bash package to PATH
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Description = "Set /sys/firmware/acpi/platform_profile";
      Type = "oneshot";
      User = "root";
      ExecStart = "${pkgs.bash}/bin/bash -c \"chmod a+w /sys/firmware/acpi/platform_profile\"";
    };
  };

  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];
  nixpkgs.overlays = flake-overlays;
  networking.hostId = "6b216942";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.thulashitharan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gamemode"
      "networkmanager"
      "plugdev"
      "dialout"
      "scanner"
      "video"
      "lp"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      brave
      kicad
      tree
      google-chrome
      audacity
      element-desktop-wayland
      spotify
      arduino-cli
      anydesk
      easyeffects
      skanpage
      flashprint
      grc
      speedtest-rs
      telegram-desktop
      zip
      discord
      ani-cli
      hyprshade
      qview
      gimp
      qbittorrent
      wofi-emoji
      obsidian
      yt-dlp
      mpv
      grim
      swappy
      satty
      super-productivity
    ];
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = 1;
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    quickemu
    git
    neovim
    gcc
    wireshark-qt
    qemu
    gdb
    gnumake
    sbctl
    efitools
    matlab
    efibootmgr
    linux-router
    gitui
    aria2
    ripgrep
    python3
    macchanger
    lenovo-legion
    fastfetch
    yq-go
    cloudflare-warp
    rpi-imager
    ripgrep
    speedtest-rs
    lan-mouse
    ffmpeg
    smartmontools
    unzip
    clevis
    linuxPackages_cachyos.cpupower
    catppuccin-sddm
    unrar
    gh
    nixfmt-rfc-style
    libnotify
    usbutils
    just
    cachix
    lm_sensors
    qogir-icon-theme
    morewaita-icon-theme
    gnome-keyring
    libgnome-keyring
    libsecret
    adwaita-icon-theme
    libreoffice-qt6-fresh
    lxqt.lxqt-policykit
    clang-tools
  ];
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images

  fonts.packages = with pkgs; [
    noto-fonts-cjk
    noto-fonts
    corefonts
    vistafonts
    libertine
    dejavu_fonts
    inconsolata
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
