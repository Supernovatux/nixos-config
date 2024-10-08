{
  inputs,
  config,
  pkgs,
  ...
}:
let
  fish_conf = {
    enable = true;
    enableFishIntegration = true;
  };
in
{
  imports = [
    ./hyprland.nix
    ./ags.nix
    ./theme.nix
    ./yazi.nix
    ./vscode.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thulashitharan";
  home.homeDirectory = "/home/thulashitharan";
  programs.fish.shellAbbrs = {
    cd = "z";
    lsblk = "lsblk -o NAME,LABEL,SIZE,FSTYPE,FSUSED,MOUNTPOINT";
    ls = "eza -l --icons=always";
    cat = "bat";
  };
  programs.command-not-found.enable = true;
  services.gnome-keyring.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thulashitharan/etc/profile.d/hm-session-vars.shell
  home.sessionVariables = {
    EDITOR = "nvim";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.fzf = fish_conf;
  programs.zoxide = fish_conf;
  programs.eza = fish_conf;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    functions = {

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      yy = "set tmp (mktemp -t \"yazi-cwd.XXXXXX\") \n yazi $argv --cwd-file=\"$tmp\" \n if set cwd (cat -- \"$tmp\"); and [ -n \"$cwd\" ]; and [ \"$cwd\" != \"$PWD\" ] \n cd -- \"$cwd\" \n end \n rm -f -- \"$tmp\"";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };
  programs.nixvim = import ./nixvim/default.nix;
  programs.kitty = import ./kitty.nix;
  programs.starship = import ./starship.nix;
  #programs.sioyek.enable = true;
  programs.sioyek.package = inputs.sioyek-git-flake.packages.x86_64-linux.sioyek;
  programs.mcfly = fish_conf;
  nixpkgs.config = {
    allowUnfree = true;
  };
}
