{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      grammarPackages = [
        pkgs.vimPlugins.nvim-treesitter-parsers.qmljs
      ];

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;
  };
}
