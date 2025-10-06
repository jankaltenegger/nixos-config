{
  programs.nixvim.plugins.snacks = {
    enable = true;
    luaConfig.post = ''
      opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        dim = { enabled = true },
      }
    '';
  };
}
