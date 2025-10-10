{
  pkgs,
  lib,
  inputs,
  secrets,
  ...
}: {
  imports = [
    ./neovim
    ./hyprland
    ./swayosd
    ./swaync
    ./rmpc
    ./starship
  ];

  home.packages = with pkgs; [
    prismlauncher #Minecraft 3rdP launcher
    tdesktop # Messaging App
    httpie # CLI ARC/Postman Solution
    libreoffice-qt6-fresh # Office Suite Equivalent
    grim # For ScreenShots
    slurp # For Screenshots
    obsidian # Note-taking Software
    calibre # Book Management Software
    clapper # Video Viewer
    gthumb # Media Viwer
    devenv # Development environments made easy
    mullvad-vpn # VPN
    kicad # Electronics Design Suite
    vesktop
    cozy #Audiobook player
    geckodriver
    gnome-disk-utility
    heroic
    bottles
    mangohud
    transmission_4-gtk
    bluetui
    docker
    zap
    spotify
    ouch
    exiftool
    kdePackages.okular
    ripdrag
  ];

  programs = {
    yazi = {
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
              run = "ouch d -y '$@'";
              desc = "Extract here with ouch";
              for = "unix";
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

    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "nord";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      environment.EDITOR = "nvim";
      settings = {
        scrollback_lines = 10000;
        update_check_interval = 0;
        confirm_os_window_close = 0;
        font_size = 20;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      initContent = let
        zshConfigEarlyInit = lib.mkOrder 500 ''
          eval "$(direnv hook zsh)"
          fastfetch
        '';
        zshConfig = lib.mkOrder 1000 ''
          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            IFS= read -r -d "" cwd < "$tmp"
            [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
            rm -f -- "$tmp"
          }
        '';

        exportStarshipDuration = lib.mkOrder 2000 ''
          autoload -Uz add-zsh-hook
          _export_starship_duration() {
            # If Starship set a duration for the last command, export it
            if [[ -n "$STARSHIP_DURATION" ]]; then
              export STARSHIP_DURATION
            fi
          }
          add-zsh-hook precmd _export_starship_duration
        '';
      in
        lib.mkMerge [zshConfigEarlyInit zshConfig exportStarshipDuration];

      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/jan/nixos-config/";
        nrsc = "git add -A && sudo nixos-rebuild switch --flake /home/jan/nixos-config/ && git commit";
        rmpctty = "kitty --detach --hold -e rmpc";
        findimp = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude '{tmp,etc/passwd,home/jan/.cache/nvim}'";
      };

      syntaxHighlighting = {
        enable = true;
      };
    };

    bash.enable = true;

    zoxide.enable = true;

    fastfetch = {
      enable = true;
    };

    jq.enable = true;

    lazygit.enable = true;

    git = {
      enable = true;
      userName = "jankaltenegger";
      userEmail = "jkaltenegger@ggc.edu";
      #extraConfig = {
      #  user.email = "${secrets.github.email}";
      #};
    };
  };
}
