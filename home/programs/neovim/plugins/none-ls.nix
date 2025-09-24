{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings = {
      updateInInsert = false;
    };
    sources = {
      code_actions = {
        gitsigns.enable = false;
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        cppcheck = {
          enable = true;
          settings = {
            disabled_filetypes = [
              "h"
              "hpp"
            ];
            extra_args = [
              #"--enable=all"
              "--enable=warning,style,performance,portability"
              "--check-level=exhaustive"
              "--template=gcc"
              "--std=c17"
              "--inline-suppr"
              "--suppress=missingInclude"
              "--suppress=checkersReport"
              #"--addon=misra.py"
            ];
            rootPatterns = [
              ".git"
              "compile_commands.json"
            ];
          };
        };
        checkmake.enable = true;
      };
      formatting = {
        alejandra = {
          enable = true;
        };
        black = {
          enable = true;
          settings = ''
            {
              extra_args = { "--fast" },
            }
          '';
        };
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings = ''
            {
              extra_args = { "--no-semi", "--single-quote" },
            }
          '';
        };
        clang_format.enable = true;
        stylua.enable = true;
        phpcbf.enable = true;
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
