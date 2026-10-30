{
  pkgs,
  unstable-pkgs,
  inputs,
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
      protonup-qt
      prismlauncher #Minecraft 3rdP launcher
      telegram-desktop # Messaging App
      httpie # CLI ARC/Postman Solution
      grim # For ScreenShots
      slurp # For Screenshots
      obsidian # Note-taking Software
      calibre # Book Management Software
      (symlinkJoin {
        name = "clapper-auto-gpu";
        paths = [ pkgs.clapper ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/clapper \
            --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0" \
            --run '
              for n in /sys/class/drm/renderD*; do
                if grep -qi "PCI_ID=1002:744C" "$n/device/uevent" 2>/dev/null; then
                  node=$(basename "$n")
                  export MESA_VK_DEVICE_SELECT=1002:744c
                  export DRI_PRIME=1002:744c
                  export GST_PLUGIN_FEATURE_RANK="va''${node}h264dec:512,va''${node}h265dec:512,va''${node}av1dec:512,va''${node}vp9dec:512"
                fi
              done
            '

          for f in $out/share/applications/*.desktop; do
            src=$(readlink -f "$f"); rm "$f"; install -m644 "$src" "$f"
            sed -i "s|${pkgs.clapper}/bin/clapper|$out/bin/clapper|g" "$f"
          done
        '';
      })
      libva-utils # vainfo: list VA-API decode/encode profiles
      gst_all_1.gstreamer # gst-inspect-1.0 / gst-launch-1.0
      nvtopPackages.full # per-GPU decode-engine (VCN) monitoring
      gthumb # Media Viwer
      qview # Image Viewer
      resvg # SVG Renderer
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
      (brave.override {
        commandLineArgs = [
          "--force-device-scale-factor=1.5"
          "--no-default-browser-check"
        ];
      })
      wl-clipboard
      rofi
      xournalpp

      # Volume and Brightness Util
      brightnessctl
      playerctl

      # Icons and Cursors
      nordic
      nordzy-icon-theme
      bibata-cursors

      # QT Compatibility
      hyprland-qt-support
      inputs.quickshell.packages.x86_64-linux.default

      libreoffice-qt6-fresh
      rimsort

      gimp
      kdePackages.okular

      obs-studio
      vscode
      arduino-language-server
      arduino-cli
      arduino-ide
      claude-monitor

      saleae-logic-2

      kdePackages.kdenlive

      kicad
    ]
    ++ (with unstable-pkgs; [
      secretspec
      github-copilot-cli
      ripdrag
      claude-code
    ]);

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "nord";
      };
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
      settings.user = {
        name = "jankaltenegger";
        email = "jkaltenegger@ggc.edu";
      };
      #extraConfig = {
      #  user.email = "${secrets.github.email}";
      #};
    };
  };
}
