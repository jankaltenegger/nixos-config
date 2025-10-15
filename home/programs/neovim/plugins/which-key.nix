{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      delay = 200;
      win = {
        border = "double";
        title_pos = "left";
      };
      spec = [
        {
          __unkeyed = "<leader>f";
          group = "Picker Find";
        }
        {
          __unkeyed = "<leader>g";
          group = "Picker Git";
        }
        {
          __unkeyed = "<leader>s";
          group = "Picker Search";
        }
        {
          __unkeyed = "<leader>y";
          group = "Yazi";
          icon = {
            icon = "󰇥 ";
            hl = "WhichKeyIconGreen";
          };
        }
        {
          __unkeyed = "<leader>x";
          group = "Diagnostics";
          icon = {
            icon = "󰋗 ";
            hl = "WhichKeyIconOrange";
          };
        }
        {
          __unkeyed = "<leader>c";
          group = "Format current buffer";
          icon = {
            icon = "󰉣";
            hl = "WhichKeyIconGreen";
          };
        }
      ];
    };
  };
}
