{
  pkgs,
  inputs,
  ...
}: {
  imports = [./plugins];
  home.packages = with pkgs; [
    wl-clipboard
    rofi-wayland

    # File Manager
    xfce.thunar
    xfce.thunar-volman
    xfce.xfconf
    xfce.tumbler
    xfce.thunar-archive-plugin

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
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];

    settings = {
      ##################
      # CONF VARIABLES #
      ##################

      "$MOD" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";

      ######################
      # STARTUP EXECUTIONS #
      ######################
      exec-once = [
        "hyprlock"
        "hypridle"
        "[workspace special silent] vesktop"
        "[workspace special silent] obsidian"
        "[workspace special silent] telegram-desktop"
        "sleep 5; swayosd-server"
      ];

      ############
      # MONITORS #
      ############
      monitor = [
        "eDP-1, 2560x1600@165, auto, 1"
        "desc:Samsung Electric Company Odyssey G95NC HNTX601558, 7680x2160@240, auto, 1"
      ];

      #########################
      # ENVIRONMENT VARIABLES #
      #########################
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
      ];

      ################
      # WINDOW RULES #
      ################

      # Zen Browser
      windowrule = [
        "opacity 1.0 override 0.875 override 1.0 override, initialTitle:(Zen Browser)"
        "workspace special silent, class:(vesktop)"
        "opacity 1.0 override, class:(Turing Complete)"
        "opacity 1.0 override, title:(ZenlessZoneZero)"
        "opacity 1.0 override, class:(.*Minecraft.*)"
        "opacity 0.7 override, class:(kitty)"
        "opacity 1.0 override, title:(Lilith's Throne 0.4.11.3 Alpha)"
        "opacity 1.0 override, class:(jam-app)"
      ];

      #################
      # GENERAL BINDS #
      #################
      bind = [
        "$MOD, Return, exec, $terminal"
        "$MOD SHIFT, Q, killactive"
        "$MOD CTRL, Q, exit"
        "$MOD, W, exec, $browser"
        "$MOD SHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "$MOD, E, exec, thunar"
        "$MOD, C, togglefloating,"
        "$MOD, C, centerwindow,"
        "$MOD, F, fullscreen, 0"
        "$MOD SHIFT, F, fullscreen, 1"
        "$MOD, R, exec, rofi -show drun"
        "$MOD, X, togglespecialworkspace"
        "$MOD, M, exec, hyprlock"

        "$MOD, H, hy3:movefocus, l"
        "$MOD, J, hy3:movefocus, d"
        "$MOD, K, hy3:movefocus, u"
        "$MOD, L, hy3:movefocus, r"
        "$MOD SHIFT, H, hy3:movewindow, l"
        "$MOD SHIFT, J, hy3:movewindow, d"
        "$MOD SHIFT, K, hy3:movewindow, u"
        "$MOD SHIFT, L, hy3:movewindow, r"
        "$MOD CTRL, H, resizeactive, -20 0"
        "$MOD CTRL, J, resizeactive, 0 20"
        "$MOD CTRL, K, resizeactive, 0 -20"
        "$MOD CTRL, L, resizeactive, 20 0"

        # Switch workspaces with MOD + [0-9]
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"

        # Move active window to a workspace with MOD + SHIFT + [0-9]
        "$MOD SHIFT, 1, hy3:movetoworkspace, 1"
        "$MOD SHIFT, 2, hy3:movetoworkspace, 2"
        "$MOD SHIFT, 3, hy3:movetoworkspace, 3"
        "$MOD SHIFT, 4, hy3:movetoworkspace, 4"
        "$MOD SHIFT, 5, hy3:movetoworkspace, 5"
        "$MOD SHIFT, 6, hy3:movetoworkspace, 6"
        "$MOD SHIFT, 7, hy3:movetoworkspace, 7"
        "$MOD SHIFT, 8, hy3:movetoworkspace, 8"
        "$MOD SHIFT, 9, hy3:movetoworkspace, 9"
        "$MOD SHIFT, Y, hy3:movetoworkspace, special"

        "$MOD, d, hy3:makegroup, h, ephemeral"
        "$MOD, s, hy3:makegroup, v, ephemeral"
        "$MOD, z, hy3:makegroup, tab, ephemeral"
        "$MOD CTRL, z, hy3:changegroup, untab"

        ", XF86AudioPlay, exec, swayosd-client --playerctl play-pause"
        ", XF86AudioPause, exec, swayosd-client --playerctl play-pause"
        ", XF86AudioNext, exec, swayosd-client --playerctl next"
        ", XF86AudioPrev, exec, swayosd-client --playerctl previous"

        # Elecom Deft Pro remap
        ", mouse:278, exec, notify-send 'BTN_BACK pressed'"
        ", mouse:277, exec, notify-send 'BTN_FORWARD pressed'"
        ", mouse:279, exec, notify-send 'BTN_TASK pressed'"
      ];

      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizeactive"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, swayosd-client  --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client  --brightness lower"
      ];

      general = {
        border_size = "1";
        gaps_in = "3";
        gaps_out = "5";
        layout = "hy3";
      };

      animations = {
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 5, default"
          "fade, 1, 5, default"
          "workspaces, 1, 5, default"
          "specialWorkspace, 1, 5, default, fade"
        ];
      };

      decoration = {
        rounding = "10";
        active_opacity = "0.875";
        inactive_opacity = "0.875";
        fullscreen_opacity = "1";
        blur = {
          size = "6";
          passes = "2";
        };
      };

      input = {
        kb_model = "us";
        kb_layout = "";
        kb_variant = "";
        kb_options = "";
        kb_rules = "";

        touchpad = {
          natural_scroll = "true";
          scroll_factor = "0.8";
        };
      };

      gestures = {
        workspace_swipe = "true";
        workspace_swipe_distance = "200";
        workspace_swipe_cancel_ratio = "0.35";
      };

      misc = {
        disable_splash_rendering = "true";
        vfr = "false";
        vrr = "1";
      };

      plugin = {
        hy3 = {
          group_inset = "0";
          tabs = {
            border_width = "1";
            render_text = "false";
            height = "20";
            "col.active" = "rgba(33ccff20)";
            "col.border.active" = "rgba(33ccffee)";
            "col.inactive" = "rgba(30303020)";
            "col.border.inactive" = "rgba(595959aa)";
          };
          autotile = {
            enable = "true";
            trigger_width = "800";
            trigger_height = "500";
          };
        };
      };
    };
  };
}
