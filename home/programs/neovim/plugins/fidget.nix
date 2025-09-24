{
  programs.nixvim.plugins.fidget = {
    enable = true;
    settings = {
      logger = {
        level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
      };
      progress = {
        ignore = [ ]; # List of LSP servers to ignore
        display = {
          priority = 30; # Ordering priority for LSP notification group
          overrides = {
            rust_analyzer = {
              name = "rust-analyzer";
            };
          }; # Override options from the default notification config
        };
      };
      notification = {
        filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”

        window = {
          winblend = 0;
          border = "none"; # none, single, double, rounded, solid, shadow
          zindex = 45;
          align = "bottom";
          relative = "editor";
        };
      };
    };
  };
}
