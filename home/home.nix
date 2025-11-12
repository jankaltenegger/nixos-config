{
  pkgs,
  unstable-pkgs,
  ...
}: let
  username = "jan";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  myPackages = with pkgs; [
    any-nix-shell #zsh support for nix shell
    gammastep # F.LUX FOR LINUX???
    geoclue2
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
    stateVersion = "24.05";
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
