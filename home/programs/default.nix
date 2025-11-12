{
  pkgs,
  unstable-pkgs,
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
    ./zsh
    ./yazi
  ];

  home.packages = with pkgs;
    [
      prismlauncher #Minecraft 3rdP launcher
      tdesktop # Messaging App
      httpie # CLI ARC/Postman Solution
      grim # For ScreenShots
      slurp # For Screenshots
      obsidian # Note-taking Software
      calibre # Book Management Software
      clapper # Video Viewer
      gthumb # Media Viwer
      devenv # Development environments made easy
      mullvad-vpn # VPN
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

      wl-clipboard
      rofi-wayland

      # Volume and Brightness Util
      brightnessctl
      playerctl

      # Icons and Cursors
      nordic
      nordzy-icon-theme
      bibata-cursors

      # QT Compatibility
      qt6.full
      inputs.quickshell.packages.x86_64-linux.default

      kicad

      libreoffice-qt6-fresh
    ]
    ++ (with unstable-pkgs; [
      secretspec
    ]);

  programs = {
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
