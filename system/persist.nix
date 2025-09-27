{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"

      "/etc/ssh"

      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
    ];

    users.jan = {
      directories = [
        "nixos-config"

        ".zen"
        ".cache/zen"

        ".config/1Password"

        ".config/vesktop"
        ".config/obsidian"
        ".local/share/TelegramDesktop"

        ".config/zellij"
        ".cache/zellij"
        ".cache/fastfetch"

        ".local/share/zoxide"
        ".local/share/direnv"
        ".ssh"

        "devenv"
        "Downloads"
        "Documents"
        "Calibre Library"
        "Music"
        "Pictures"
        "Videos"
        "vm"
      ];

      files = [
        ".local/share/hyprland/lastVersion"
        ".bash_history"
        ".config/systemsettingsrc"
        ".zsh_history"
      ];
    };
  };
}
