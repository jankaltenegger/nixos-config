{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"

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
        # NixOS Configuration
        "nixos-config"

        # Zen Browser
        ".zen"
        ".cache/zen"

        # 1Password
        ".config/1Password"

        # Vesktop / Discord
        ".config/vesktop"

        # Obsidian
        ".config/obsidian"

        # Telegram
        ".local/share/TelegramDesktop"

        # Zellij
        ".config/zellij"
        ".cache/zellij"

        # Fastfetch (faster loading)
        ".cache/fastfetch"

        # User Folders
        "devenv"
        "Downloads"
        "Documents"
        "Calibre Library"
        "Music"
        "Pictures"
        "Videos"
        "vm"

        # Misc
        ".local/share/zoxide"
        ".local/share/direnv"
        ".local/state/wireplumber" # For BT auto-connect
        ".ssh"
      ];

      files = [
        ".local/state/lazygit/state.yml"
        ".local/share/hyprland/lastVersion"
        ".bash_history"
        ".config/systemsettingsrc"
        ".zsh_history"
      ];
    };
  };
}
