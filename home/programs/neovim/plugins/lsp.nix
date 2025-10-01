{
  pkgs,
  unstable-pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          phpactor.enable = true;
          clangd.enable = true;
          nil_ls = {
            enable = true;
            settings.nix.flake.autoArchive = true;
            settings.formatting.command = ["alejandra"];
          };
          pyright.enable = true;
          lua_ls.enable = true;
          ts_ls.enable = true;
          html.enable = true;
          cssls = {
            enable = true;
            filetypes = ["css" "scss"];
          };
          tailwindcss = {
            enable = true;
          };

          qmlls = {
            enable = true;
            cmd = ["qmlls" "-E"];
            filetypes = ["qml"];
            rootMarkers = [".git"];
          };
        };
      };
    };
  };
}
