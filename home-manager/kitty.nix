{
  enable = true;
  font.name = "Fira Code Nerd Font";
  shellIntegration.enableFishIntegration = true;
  theme = "Space Gray Eighties";
  keybindings = {
    "ctrl+shift+t" = "new_tab_with_cwd";
  };
  settings = {
    scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
    show_hyperlink_targets = "no";
    enable_audio_bell = "yes";
    shell = "fish";
    editor = "nvim";
    tab_bar_style = "powerline";
    tab_powerline_style = "round";
  };
}
