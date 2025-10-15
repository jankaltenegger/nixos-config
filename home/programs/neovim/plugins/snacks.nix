{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      bigfile = {
        enabled = true;
      };
      indent = {
        enabled = true;
        char = "w";
      };
      bufdelete = {
        enabled = true;
      };
      picker = {
        enabled = true;
      };
    };
  };
}
