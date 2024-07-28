{ pkgs, ... }:
let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "0dc9dcd5794ca7910043174ec2f2fe3561016983";
    hash = "sha256-8RanvdS62IqkkKfswZUKynj34ckS9XzC8GYI9wkd3Ag";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    plugins = {
      chmod = "${plugins-repo}/chmod.yazi";
      max-preview = "${plugins-repo}/max-preview.yazi";
      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "0a141f6dd80a4f9f53af8d52a5802c69f5b4b618";
        sha256 = "sha256-OL4kSDa1BuPPg9N8QuMtl+MV/S24qk5R1PbO0jgq2rA=";
      };
    };
    initLua = ./init.lua;
    settings = {
      manager = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "T" ];
          run = "plugin --sync max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };
  };
}
