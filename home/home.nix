{
  pkgs,
  unstable-pkgs,
  ...
}: let
  username = "jan";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  myPackages = with pkgs; [
    geoclue2
    any-nix-shell #zsh support for nix shell
    eza # ls replacement
    fd # find replacement
    libnotify # notify-send command (no clue what this does)
    ripgrep # faster grep
    tldr # community man pages
    tree # display files in a tree view
  ];
in {
  imports = [
    ./programs
    ./services
  ];

  home = {
    inherit username homeDirectory;
    packages = myPackages;
    stateVersion = "26.05";
  };

  xdg = {
    inherit configHome;
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      publicShare = null;
      templates = null;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["zen.desktop"];
        "x-scheme-handler/http" = ["zen.desktop"];
        "x-scheme-handler/https" = ["zen.desktop"];
        "image/svg+xml" = ["zen.desktop"];
        "image/jpeg" = ["com.interversehq.qView.desktop"];
        "image/png" = ["com.interversehq.qView.desktop"];
        "image/gif" = ["com.interversehq.qView.desktop"];
        "image/webp" = ["com.interversehq.qView.desktop"];
        "image/bmp" = ["com.interversehq.qView.desktop"];
        "image/tiff" = ["com.interversehq.qView.desktop"];
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
    };
    iconTheme = {
      name = "Nordzy-dark";
    };
  };
}
