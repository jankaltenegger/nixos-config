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
          "nord.nvim"
        ];
        pathsToLink = [
          "./doc/tags"
        ];
      };

      byteCompileLua.enable = false;
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      lush-nvim
    ] ++ [(pkgs.vimUtils.buildVimPlugin {
      name = "sidekick-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "sidekick.nvim";
        rev = "7185e0863ba9f533b39d699243ee65c2f16062af";
        hash = "sha256-FsRxXWNDNBFMVF4yMPubY0zsk6Cip0Wquq/ql3Y0o88=";
      };
      doCheck = false;
    })];
  };
}
