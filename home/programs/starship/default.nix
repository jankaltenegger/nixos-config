{
  lib,
  config,
  ...
}: let
  devMode = false;
  devPath = "/home/jan/devenv/impure/starship/starship.toml";
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.mkIf (!devMode) {
      palette = "nord";
      add_newline = true;
      format = lib.concatStrings [
        "[╔](nord3)"
        "[](bg:nord0 fg:nord3)"
        "[](bg:nord1 fg:nord3)"
        "($nix_shell)"
        "$directory"
        "([ ](bg:nord2 fg:nord1)$git_branch($git_status))"
        "($\{custom.git_sep_in\})($\{custom.git_sep_out\})"
        "[](nord3)"
        "$fill"
        "[](bg:nord0 fg:nord3)"
        "($\{custom.cmd_fast\})($\{custom.cmd_medium\})($\{custom.cmd_slow})($\{custom.cmd_off\})"
        "$battery"
        "[ ](bg:nord2 fg:nord1)"
        "$time"
        "[](bg:nord1 fg:nord3)"
        "[](nord3)"
        "$line_break"
        "[╙](nord3)"
        "[─](nord3)"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$singularity"
        "$kubernetes"
        "$vcsh"
        "$fossil_branch"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cpp"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$vlang"
        "$vagrant"
        "$zig"
        "$buf"
        "$conda"
        "$pixi"
        "$meson"
        "$spack"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$crystal"
        "$custom"
        "$status"
      ];

      palettes.nord = {
        nord0 = "#2e3440";
        nord1 = "#3b4252";
        nord2 = "#434c5e";
        nord3 = "#4c566a";
        nord4 = "#d8dee9";
        nord5 = "#e5e9f0";
        nord6 = "#eceff4";
        nord7 = "#8fbcbb";
        nord8 = "#88c0d0";
        nord9 = "#81a1c1";
        nord10 = "#5e81ac";
        nord11 = "#bf616a";
        nord11_dark = "#765054";
        nord11_bright = "#ff7482";
        nord12 = "#d08770";
        nord12_dark = "#a35c45";
        nord12_bright = "#ed7e5c";
        nord13 = "#ebcb8b";
        nord13_dark = "#917b59";
        nord13_bright = "#ffd179";
        nord14 = "#a3be8c";
        nord14_dark = "#5a7352";
        nord14_bright = "#82c276";
        nord15 = "#b48ead";
        nord15_dark = "#705b6c";
        nord15_bright = "#d3bad7";
      };

      nix_shell = {
        format = "[ $symbol $state ]($style)[](bg:nord1 fg:nord3)";
        symbol = " ";
        impure_msg = "[⌽](bold bg:nord1 fg:nord11)";
        pure_msg = "[⌾](bold bg:nord1 fg:nord14)";
        unknown_msg = "[◌](bold bg:nord1 fg:nord13)";
        style = "bg:nord1 fg:nord8";
      };

      git_branch = {
        format = "[$symbol $branch(:$remote_branch) ]($style)";
        style = "bg:nord2 fg:nord15";
        symbol = "";
      };

      git_status = {
        format = "[(\\[$all_status$ahead_behind\\])]($style)";
        style = "bg:nord2 fg:nord11";
      };

      battery = {
        format = "[ $percentage $symbol]($style)";
        full_symbol = "🜂 ";
        charging_symbol = "🜂 🝞 ";
        discharging_symbol = "🜂 🝟 ";
        unknown_symbol = "🜂 ";
        empty_symbol = "🜂 🜔 ";
        display = [
          {
            threshold = 100;
            style = "bg:nord2 fg:nord14";
          }
          {
            threshold = 60;
            style = "bg:nord2 fg:nord13";
          }
          {
            threshold = 30;
            style = "bg:nord2 fg:nord12";
          }
          {
            threshold = 15;
            style = "bg:nord2 fg:nord11";
          }
        ];
      };

      fill = {
        symbol = "═";
        style = "bold nord2";
      };

      character = {
        format = "$symbol ";
        success_symbol = "[🜹](bold nord8)";
        error_symbol = "[🜹](bold nord11)";
        vimcmd_symbol = "[🜹](bold nord15)";
        vimcmd_replace_one_symbol = "[🜹](bold nord15)";
        vimcmd_replace_symbol = "[🜹](bold nord15)";
        vimcmd_visual_symbol = "[🜹](bold nord13)";
      };

      directory = {
        format = "[ $path ]($style)";
        style = "fg:nord6 bg:nord1";
        truncation_length = 2;
        truncation_symbol = "🜎  ";
      };

      time = {
        disabled = false;
        format = "[ $time 🜄 ]($style)";
        style = "italic bg:nord1 fg:nord6";
        time_format = "%R";
        utc_time_offset = "local";
      };

      aws = {
        disabled = true;
      };

      deno = {
        format = " [ $version](bold nord14_bright)";
        version_format = "$raw";
      };

      lua = {
        format = " [$symbol$version]($style)";
        version_format = "$raw";
        symbol = " ";
        style = "bold nord9";
      };

      nodejs = {
        format = " [ ($version)](bold nord14_dark)";
        version_format = "$raw";
        detect_files = ["package-lock.json" "yarn.lock"];
        detect_folders = ["node_modules"];
        detect_extensions = [];
      };

      python = {
        format = " [$symbol$version]($style)";
        symbol = "[ ](bold nord9)";
        version_format = "$raw";
        style = "bold nord13_bright";
      };

      ruby = {
        format = " [$symbol$version]($style)";
        symbol = " ";
        version_format = "$raw";
        style = "bold nord11";
      };

      rust = {
        format = " [$symbol$version]($style)";
        symbol = " ";
        version_format = "$raw";
        style = "bold nord12";
      };

      package = {
        format = " [$symbol$version]($style)";
        version_format = "$raw";
        symbol = "󰏖 ";
        style = "dimmed italic bold nord13_dark";
      };

      swift = {
        format = " [$symbol$version]($style)";
        symbol = " ";
        style = "bold nord12_bright";
        version_format = "$raw";
      };

      buf = {
        symbol = " ";
        format = " [$symbol $version $buf_version]($style)";
      };

      c = {
        symbol = " ";
        format = " [$symbol($version(-$name))]($style)";
      };

      cpp = {
        symbol = " ";
        format = " [$symbol($version(-$name))]($style)";
      };

      conda = {
        symbol = "◯ ";
        format = " [$symbol$environment]($style)";
      };

      pixi = {
        symbol = "■ ";
        format = " [$symbol$version ($environment )]($style)";
      };

      dart = {
        symbol = " ";
        format = " [$symbol($version )]($style)";
      };

      docker_context = {
        symbol = " ";
        format = " [$symbol$context]($style)";
      };

      elixir = {
        symbol = " ";
        format = " [$symbol $version OTP $otp_version ]($style)";
      };

      elm = {
        symbol = " ";
        format = " [$symbol($version )]($style)";
      };

      golang = {
        symbol = " ";
        format = " [$symbol($version )]($style)";
      };

      haskell = {
        symbol = " ";
        format = " [$symbol($version )]($style)";
        style = "bold nord15_bright";
      };

      java = {
        format = " [$symbol($version )]($style)";
        style = "bold nord11_bright";
      };

      julia = {
        symbol = " ";
        format = " [$symbol($version )]($style)";
      };

      nim = {
        symbol = "▴▲▴ ";
        format = " [$symbol($version )]($style)";
      };

      spack = {
        symbol = " ";
        format = " [$symbol$environment]($style)";
      };

      custom = {
        git_sep_in = {
          when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1";
          command = "printf ''";
          format = "[$output](bg:nord2 fg:nord3)";
        };

        git_sep_out = {
          when = "! git rev-parse --is-inside-work-tree >/dev/null 2>&1";
          command = "printf ''";
          format = "[$output](bg:nord1 fg:nord3)";
        };

        cmd_fast = {
          when = "[ -n \"$STARSHIP_DURATION\" ] && [ \"$STARSHIP_DURATION\" -ge 2000 ] && [ \"$STARSHIP_DURATION\" -lt 20000 ]";
          command = "printf \"%ds\" \"(($\{STARSHIP_DURATION\}/1000))\"";
          format = "[](bg:nord10 fg:nord3)[ $output 🜏 ](bg:nord10)[ ](bg:nord10 fg:nord2)";
        };

        cmd_medium = {
          when = "[ -n \"$STARSHIP_DURATION\" ] && [ \"$STARSHIP_DURATION\" -ge 20000 ] && [ \"$STARSHIP_DURATION\" -lt 60000 ]";
          command = "printf \"%ds\" \"$(($\{STARSHIP_DURATION\}/1000))\"";
          format = "[](bg:nord10 fg:nord3)[ $output 🜏 ](bg:nord10)[ ](bg:nord10 fg:nord2)";
        };

        cmd_slow = {
          when = "[ -n \"$STARSHIP_DURATION\" ] && [ \"$STARSHIP_DURATION\" -ge 60000 ]";
          command = "printf \"%dm%02ds\" \"(($\{STARSHIP_DURATION\}/60000))\" \"(( ($\{STARSHIP_DURATION\}%60000)/1000 ))\"";
          format = "[](bg:nord10 fg:nord3)[ $output 🜏 ](bg:nord10)[ ](bg:nord10 fg:nord2)";
        };

        cmd_off = {
          when = "[ -z \"$STARSHIP_DURATION\" ] || [ \"$STARSHIP_DURATION\" -lt 2000 ]";
          format = "[](bg:nord2 fg:nord3)";
        };
      };
    };
  };

  xdg.configFile."starship.toml".enable = lib.mkForce (!devMode);
  home.file.".config/starship.toml" = lib.mkIf devMode {
    source = config.lib.file.mkOutOfStoreSymlink devPath;
    force = true;
  };
}
