{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs; [
      vscode-extensions.ms-python.python
      vscode-marketplace.platformio.platformio-ide
      vscode-extensions.ms-toolsai.jupyter
      vscode-extensions.ms-vscode.cpptools
      vscode-extensions.mkhl.direnv
      vscode-extensions.ms-python.black-formatter
    ];
  };
}
