{pkgs, ...}: {
  programs.nixvim = {
    opts.completeopt = ["menu" "menuone" "noselect"];

    plugins = {
      # Don't crucify me please

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
        filetypeExtend = {
          php = [
            "html"
          ];
          typescriptreact = [
            "html"
          ];
          javascriptreact = [
            "html"
          ];
        };
      };

      lspkind = {
        enable = true;

        settings.cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          experimental = {
            ghost_text = true;
          };
          snippet.expand = "luasnip";

          performance.max_view_entries = 30;

          window = {
            completion = {
              border = "rounded";
            };
            documentation.border = "rounded";
          };

          formatting = {
            fields = [
              "kind"
              "abbr"
              "menu"
            ];
          };

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
          };

          sources = [
            {
              name = "nvim_lsp";
            }
            {
              name = "neorg";
            }
            {
              name = "path";
            }
            {
              name = "luasnip";
            }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keyword_length = 3;
            }
          ];
        };
      };
    };
  };
}
