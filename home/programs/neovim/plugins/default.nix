{
  imports = [
    ./lsp.nix
    ./startify.nix
    ./treesitter.nix
    ./floaterm.nix
    ./lualine.nix
    ./telescope.nix
    ./fidget.nix
    ./none-ls.nix
    ./nvim-notify.nix
    ./hardtime.nix
    ./flash.nix
    ./trouble.nix
    ./snacks.nix
  ];

  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      nvim-surround.enable = true;

      colorizer = {
        enable = true;
      };

      trim = {
        enable = true;
        settings = {
          hightight = true;
          ft_blocklist = [
            "floaterm"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
