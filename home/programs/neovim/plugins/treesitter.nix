{pkgs, ...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;

      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };

    treesitter-refactor = {
      enable = false;
      settings.highlight_definitions = {
        enable = true;
        clear_on_cursor_move = false;
      };
    };

    hmts = {
      enable = true;
      package = pkgs.vimPlugins.hmts-nvim.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/calops/hmts.nvim/pull/38.patch";
            hash = "sha256-GXqUtqqhbkJCSkLJ3cz4AgiY3mKpAAg2F4aQhEjZVtM=";  # fill in after the first failed build
          })
        ];
      });
    };

  };
}
