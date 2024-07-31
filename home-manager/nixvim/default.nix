# nixvim.nix
{
  keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
    ];
  enable = true;
  opts = {
    undofile = true; # Build-in persistent undo
    autoindent = true;
    clipboard = "unnamedplus";
    number = true;         # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2;        # Tab width should be 2
  };
  clipboard.providers.wl-copy.enable = true;
  clipboard.register = "unnamedplus";
  globals.mapleader = " ";
  plugins = let 
     cmp = import ./cmp.nix;
     lsp = import ./lsp.nix;
  in {
    bufferline.enable = true;
    neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
      };
    nvim-autopairs.enable = true;
    telescope.enable = true;
    treesitter = {
      enable = true;
      nixGrammars = true;
      settings.indent.enable = true;
    };
    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;
    texpresso.enable = true;
    which-key.enable = true;
    conform-nvim = {
	enable = true;
        
	formattersByFt = {
	  nix = "nixfmt";
	};
      };
  } // cmp //lsp;
}
