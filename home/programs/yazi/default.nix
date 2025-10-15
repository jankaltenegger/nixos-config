{
  inputs,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = inputs.yazi.packages.${pkgs.system}.yazi;
    plugins = {
      inherit (pkgs.yaziPlugins) ouch;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          run = "plugin ouch";
          on = ["C"];
          desc = "Compress with ouch";
        }
        {
          run = ''
            shell -- if [ $# -eq 1 ]; then
              ripdrag -i -x -W 256 -H 256 -s 250 "$1"
            else
              ripdrag -a -W 500 -H 500 -s 100 "$@"
            fi
          '';
          on = ["<C-d>"];
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
