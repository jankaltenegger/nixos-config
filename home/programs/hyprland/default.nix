{
  pkgs,
  lib,
  ...
}: let
  # DEVMODE/FAST ITERATION
  devMode = false;
  devPath = "/home/jan/devenv/impure/hypr";

  makeScreenshotScript = pkgs.writeShellScriptBin "make-screenshot" ''
    mkdir -p "$HOME/Pictures/Screenshots/$(date +%F)"

    find "$HOME/Pictures/Screenshots/$(date +%F)" -maxdepth 1 -type f -name 'Screenshot-*-*.png' -printf '%f\n' 2>/dev/null \
      | awk -F'-' 'match($2,/^[0-9]+$/){print $0"\t"$2}' \
      | sort -k2,2nr \
      | cut -f1 \
      | while IFS= read -r name; do
          mv -- "$HOME/Pictures/Screenshots/$(date +%F)/$name" \
                "$HOME/Pictures/Screenshots/$(date +%F)/Screenshot-$(printf '%03d' $((10#$(echo "$name" | cut -d- -f2)+1)))-$(echo "$name" | cut -d- -f3-)"
        done

    dir="$HOME/Pictures/Screenshots/$(date +%F)"
    file="$dir/Screenshot-000-$(date +%H%M-%m-%d-%y).png"

    # Capture screenshot to file only
    if grim -g "$(slurp -d)" "$file"; then
      # Only copy if the file isn't empty
      if [ -s "$file" ]; then
        wl-copy < "$file"
        notify-send "Screenshot" "Saved and copied: $(basename "$file")"
      else
        rm -f "$file"
        notify-send "Screenshot" "Canceled"
      fi
    else
      rm -f "$file"
      notify-send "Screenshot" "Canceled (grim failed)"
    fi
  '';

  quickdrawScreenshotScript = pkgs.writeShellScriptBin "quickdraw-screenshot" ''
    if [ -d $HOME/Pictures/Screenshots/$(date +%F) ] && [ `ls -1 $HOME/Pictures/Screenshots/$(date +%F)/Screenshot* 2>/dev/null | wc -l` -gt 0 ]; then
      ripdrag -a -b -W 800 -H 620 -s 200 $HOME/Pictures/Screenshots/$(date +%F)/Screenshot*
    else
      notify-send "No screenshots in $(date +%F) yet." --app-name="RipDrag"
    fi
  '';
in {
  imports = [./plugins];
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig =
      if devMode
      then ''
        dofile("${devPath}/hyprland.lua")
      ''
      else ''
        --------------------
        ---- AUTO START ----
        --------------------
        hl.window_rule({ match = { class = "obsidian" }, workspace = "special silent" })
        hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = "special silent" })
        hl.window_rule({ match = { class = "discord" }, workspace = "special silent" })

        hl.on("hyprland.start", function ()
          hl.exec_cmd("obsidian")
          hl.exec_cmd("Telegram")
          hl.exec_cmd("discord")
        end)

        ------------------
        ---- MONITORS ----
        ------------------
        hl.monitor({ output = "eDP-1", mode = "2560x1600@165", position = "auto", scale = 1 })
        hl.monitor({
          output = "desc:Samsung Electric Company Odyssey G95NC HNTX601558",
          mode = "7680x2160@240",
          position = "auto",
          scale = 1,
        })

        ------------------
        ---- PROGRAMS ----
        ------------------
        local mod = "SUPER"
        local terminal = "kitty"
        local browser = "zen"

        -------------------------------
        ---- ENVIRONMENT VARIABLES ----
        -------------------------------
        hl.env("XCURSOR_SIZE", "24")
        hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
        hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")
        hl.env("WLR_DRM_NO_ATOMIC", "1")
        ----------------------
        ---- WINDOW RULES ----
        ----------------------
        hl.window_rule({ match = { initial_title = "Zen Browser" }, opacity = "1.0 override 0.9 override 1.0 override" })
        hl.window_rule({ match = { title = "Picture-in-Picture" }, opacity = "1.0 override 1.0 override 1.0 override" })
        hl.window_rule({ match = { class = "brave-browser" }, opacity = "1.0 override 0.9 override 1.0 override" })
        hl.window_rule({ match = { class = "com.github.rafostar.Clapper" }, opacity = "1.0 override 1.0 override 1.0 override" })
        hl.window_rule({ match = { class = "Logic" }, opacity = "1.0 override 1.0 override 1.0 override" })
        hl.window_rule({ match = { class = "kicad" }, opacity = "1.0 override 1.0 override 1.0 override" })

        -----------------------
        ---- LOOK AND FEEL ----
        -----------------------
        hl.layout.register("columns", {
          recalculate = function(ctx)
            local n = #ctx.targets
            if n == 0 then
              return
            end

            for i, target in ipairs(ctx.targets) do
              target:place(ctx:column(i, n))
            end
          end,
        })

        hl.config({
          general = {
            border_size = 5,
            gaps_in = 10,
            gaps_out = 20,
            layout = "columns", -- requires the hy3 plugin to be loaded (see note)
            allow_tearing = true,
          },
          decoration = {
            rounding = 10,
            active_opacity = 0.8,
            inactive_opacity = 0.8,
            fullscreen_opacity = 1,
            blur = {
              enabled = true,
              size = 7,
              passes = 3,
              ignore_opacity = true,
              noise = 0.08,
              contrast = 1.5,
              xray = false,
            },
          },
        })

        --------------------
        ---- ANIMATIONS ----
        --------------------
        hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

        hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier" })
        hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "default", style = "popin 80%" })
        hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
        hl.animation({ leaf = "borderangle", enabled = true, speed = 5, bezier = "default" })
        hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
        hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
        hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "default", style = "fade" })

        ---------------
        ---- INPUT ----
        ---------------
        hl.config({
          input = {
            kb_model = "us", -- (note: looks like it belongs in kb_layout; left as-is)
            kb_layout = "",
            kb_variant = "",
            kb_options = "",
            kb_rules = "",
            touchpad = {
              natural_scroll = true,
              scroll_factor = 0.8,
            },
          },
        })

        --------------
        ---- MISC ----
        --------------
        hl.config({
          misc = {
            disable_splash_rendering = true,
            vrr = 1,
          },
        })

        -------------------------------
        ---  BINDS (representative) ---
        -------------------------------
        hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
        hl.bind(mod .. " + W", hl.dsp.exec_cmd(browser))
        hl.bind(mod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
        hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
        hl.bind(mod .. " + F", hl.dsp.window.fullscreen())        -- toggle fullscreen
        hl.bind(mod .. " + X", hl.dsp.workspace.toggle_special()) -- the unnamed special workspace
        hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
        hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
        hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
        hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
        hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
        hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
        hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
        hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
        hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("${makeScreenshotScript}/bin/make-screenshot"))
        hl.bind(mod .. " + S", hl.dsp.exec_cmd("${quickdrawScreenshotScript}/bin/quickdraw-screenshot"))

        for i = 1, 9 do
          hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
        end

        hl.bind(mod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special" }))

        -- Switch workspaces 1-9 (replaces nine near-identical lines).
        for i = 1, 9 do
          hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
        end

        -- Mouse move/resize (was bindm) -> the { mouse = true } flag.
        hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        -- Media keys (was binde) -> { repeating = true }; locked so they fire on the lock screen.
        hl.bind(
          "XF86AudioRaiseVolume",
          hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
          { locked = true, repeating = true }
        )
        hl.bind(
          "XF86AudioLowerVolume",
          hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
          { locked = true, repeating = true }
        )
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
        hl.bind(
          "XF86MonBrightnessUp",
          hl.dsp.exec_cmd("swayosd-client --brightness raise"),
          { locked = true, repeating = true }
        )
        hl.bind(
          "XF86MonBrightnessDown",
          hl.dsp.exec_cmd("swayosd-client --brightness lower"),
          { locked = true, repeating = true }
        )
      '';
  };
}
