{
  imports = [
    ./lsp.nix
    ./treesitter.nix
    ./lualine.nix
    ./none-ls.nix
    ./nvim-notify.nix
    ./hardtime.nix
    ./flash.nix
    ./trouble.nix
    ./snacks.nix
    ./noice.nix
    ./yazi-nvim.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins = {
      nui.enable = true;

      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-surround.enable = true;
      nvim-autopairs.enable = true;

      colorizer = {
        enable = true;
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
        };
      };
    };
  };
}
