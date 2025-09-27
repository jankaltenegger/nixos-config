{
  pkgs,
  secrets,
  ...
}: {
  imports = [
    ./neovim
    ./hyprland
    ./swayosd
    ./swaync
    ./rmpc
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
    firefox # Self-explanatory, I believe
    cozy #Audiobook player
    geckodriver
    gnome-disk-utility
    heroic
    bottles
    mangohud
    transmission_4-gtk
    yazi
    bluetui
    docker
    zap
    spotify
  ];

  programs = {
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
        font_size = 16;
      };
    };

    starship.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      initContent = ''
        eval "$(direnv hook zsh)"
        fastfetch
      '';

      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/jan/nixos-config/";
        nrsc = "git add -A && sudo nixos-rebuild switch --flake /home/jan/nixos-config/ && git commit";
        rmpctty = "kitty --detach --hold -e rmpc";
        findimp = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude '{tmp,etc/passwd}'";
      };

      syntaxHighlighting = {
        enable = true;
      };
    };

    bash.enable = true;

    zoxide.enable = true;

    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
      };
    };

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
