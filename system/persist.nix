{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # machine-id is used by systemd for the journal, if you don't persist this
      # file you won't be able to easily use journalctl to look at journals for
      # previous boots.
      "/etc/machine-id"
    ];
    users.jan = {
      directories = [
        "nixos-config"

        ".zen"
        ".cache/zen"

        ".config/vesktop"
        ".config/obsidian"
        ".local/share/TelegramDesktop"

        ".cache/zellij"
        ".cache/fastfetch"

        ".local/share/zoxide"

        "Downloads"
      ];
      files = [
        ".bash_history"
        ".config/systemsettingsrc"
        ".zsh_history"
      ];
    };
  };
}
