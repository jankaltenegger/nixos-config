{
  pkgs,
  unstable-pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./completion.nix
    ./keymappings.nix
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

    package = unstable-pkgs.neovim-unwrapped;

    performance = {
      combinePlugins = {
        enable = false;
        standalonePlugins = [
          "nvim-treesitter"
          "nord.nvim"
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
      vim-suda
      which-key-nvim
    ];
  };
}
