{
  luasnip.enable = true;
  cmp = {
    enable = true;
    settings = {
      experimental = { ghost_text = true; };
      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        {
          name = "buffer";
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
        }
        { name = "nvim_lua"; }
        { name = "path"; }
      ];
      mapping = {
        "<Down>" = "cmp.mapping.select_next_item()";
        "<Up>" = "cmp.mapping.select_prev_item()";
        "<C-Space>" = "cmp.mapping.complete()";
        "<S-Tab>" = "cmp.mapping.close()";
        "<Tab>" =
          # lua 
          ''
            function(fallback)
              local line = vim.api.nvim_get_current_line()
              if line:match("^%s*$") then
                fallback()
              elseif cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end
          '';
      };
    };
  };
  cmp-path.enable = true;
  cmp-nvim-lsp.enable = true;
  cmp-nvim-lsp-document-symbol.enable = true;
  cmp-nvim-lsp-signature-help.enable = true;
  cmp-latex-symbols.enable = true;
  cmp-buffer = { enable = true; };
  cmp_luasnip = { enable = true; };
}
