{lib, ...}: {
  programs.zsh = {
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
      findimp = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude '{tmp,etc/passwd,home/jan/.cache/nvim}'";
      ls = "eza --icons";
    };

    syntaxHighlighting = {
      enable = true;
    };
  };
}
