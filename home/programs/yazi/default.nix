{
  inputs,
  pkgs,
  unstable-pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.yazi;
    plugins = {
      inherit (pkgs.yaziPlugins) ouch;
      inherit (unstable-pkgs.yaziPlugins) drag;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          run = "plugin ouch";
          on = ["<C-c>"];
          desc = "Compress with ouch";
        }
        {
          run = "plugin drag";
          on = ["<C-d>"];
          desc = "Drag and drop with ripdrag";
        }
      ];
    };
    settings = {
      opener = {
        extract = [
          {
            run = "ouch d -y \"$@\"";
            desc = "Extract here with ouch";
          }
        ];
      };
      plugin = {
        prepend_previewers = [
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/vnd.rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }
          {
            mime = "application/xz";
            run = "ouch";
          }
          {
            mime = "application/x-zstd";
            run = "ouch";
          }
          {
            mime = "application/zstd";
            run = "ouch";
          }
          {
            mime = "application/java-archive";
            run = "ouch";
          }
        ];
      };
    };
  };
}
