{
  pkgs,
  unstable-pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./completion.nix
    ./keymaps.nix
    ./options.nix
    ./colorscheme.nix
    ./plugins
  ];

  home.shellAliases = {
    v = "nvim";
    sv = "sudo -E nvim";
    svi = "sudo -E nvim";
    svim = "sudo -E nvim";
    snvim = "sudo -E nvim";
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.config.allowUnfree = true;

    package = unstable-pkgs.neovim-unwrapped;

    performance = {
      combinePlugins = {
        enable = false;
        standalonePlugins = [
          "nvim-treesitter"
          "nvim-jdtls"

          "nvim-dap"
          "conform-nvim"
          "lualine.nvim"
          "flash.nvim"
          "noice.nvim"
          "nvim-notify"
          "snacks.nvim"
          "trouble.nvim"
          "which-key.nvim"
          "yazi.nvim"
          "vim-wakatime"
          "none-ls.nvim"
          "nui.nvim"
          "nvim-surround"
          "nvim-autopairs"
          "lush-nvim"
          "friendly-snippets"
        ];
        pathsToLink = [
          "./doc/tags"
        ];
      };

      byteCompileLua.enable = true;
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      lush-nvim
    ];
  };
}
