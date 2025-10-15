{
  programs.nixvim.plugins.noice = {
    enable = true;
    settings = {
      presets.long_message_to_split = true;
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      cmdline = {
        enabled = true;
      };
      messages = {
        enabled = true;
        view = "notify";
        view_error = "notify";
        view_warn = "notify";
        view_history = "messages";
        view_search = "virtualtext";
      };
      popupmenu = {
        enabled = true;
        backend = "nui";
      };
    };
  };
}
