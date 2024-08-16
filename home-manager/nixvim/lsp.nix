{
  lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };
    servers = {
      bashls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      nixd.enable = true;
      texlab.enable = true;
    };
  };
}
