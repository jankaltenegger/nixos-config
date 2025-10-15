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
        servers = {
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

      jdtls = {
        enable = true;
        luaConfig.pre = ''
          local jdtls = require('jdtls')
          local root_dir = require('jdtls.setup').find_root({ 'pom.xml', 'mvnw', 'gradlew', '.git' })
          if not root_dir or root_dir == "" then return end

          local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
          local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name
        '';

        settings = {
          cmd = [
            "jdtls"
            "-data"
            {
              __raw = "workspace_dir";
            }
          ];
          root_dir.__raw = "root_dir";
        };
      };
    };
  };
}
