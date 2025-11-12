{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      defaultModes = ["n"];
      defaultOptions = {
        silent = true;
      };

      mkList = maps:
        lib.mapAttrsToList
        (key: cfg: {
          inherit key;
          mode = cfg.mode or defaultModes;
          inherit (cfg) action;
          options =
            defaultOptions
            // (
              if cfg ? desc
              then {inherit (cfg) desc;}
              else {}
            );
        })
        maps;

      general = mkList {
        "<esc>" = {
          action = ":noh<cr>";
          desc = "Clear search highlight";
        };

        "<C-c>" = {
          action = ":b#<cr>";
          desc = "Switch to previous buffer";
        };

        ">" = {
          mode = ["v" "x"];
          action = ">gv";
          desc = "Indent and reselect";
        };

        "<" = {
          mode = ["v" "x"];
          action = "<gv";
          desc = "Unindent and reselect";
        };

        "<TAB>" = {
          mode = ["v" "x"];
          action = ">gv";
          desc = "Indent (tab) in visual mode";
        };

        "<S-TAB>" = {
          mode = ["v" "x"];
          action = "<gv";
          desc = "Unindent (shift-tab) in visual mode";
        };

        "K" = {
          mode = ["v" "x"];
          action = ":m '<-2<cr>gv=gv";
          desc = "Move block up";
        };

        "J" = {
          mode = ["v" "x"];
          action = ":m '>+1<cr>gv=gv";
          desc = "Move block down";
        };

        "<leader>ca" = {
          action.__raw = "function() vim.lsp.buf.code_action() end";
          desc = "Show code actions";
        };
      };

      yazi = mkList {
        "<leader>yy" = {
          mode = ["n" "v" "x"];
          action = "<cmd>Yazi cwd<cr>";
          desc = "Open Yazi in current working directory";
        };

        "<leader>yh" = {
          mode = ["n" "v" "x"];
          action = "<cmd>Yazi<cr>";
          desc = "Open Yazi at the current file (Yazi Here)";
        };

        "<leader>yc" = {
          mode = ["n" "v" "x"];
          action = "<cmd>Yazi toggle<cr>";
          desc = "Resume previous Yazi session (Yazi Continue)";
        };
      };

      none-ls = mkList {
        "<leader>cf" = {
          mode = ["n" "v"];
          action = "<cmd>lua vim.lsp.buf.format()<cr>";
          desc = "Format current buffer";
        };
      };

      snacks = mkList {
        "<leader>fs" = {
          action.__raw = "function() Snacks.picker.smart() end";
          desc = "Smart Find Files";
        };

        "<leader>fn" = {
          action.__raw = "function() Snacks.picker.notifications() end";
          desc = "Find Notification History";
        };

        "<leader>fb" = {
          action.__raw = "function() Snacks.picker.buffers() end";
          desc = "Find Buffers";
        };

        "<leader>fc" = {
          action.__raw = "function() Snacks.picker.files({ cwd = '/home/jan/nixos-config/home/programs/neovim'}) end";
          desc = "Find Config File";
        };

        "<leader>ff" = {
          action.__raw = "function() Snacks.picker.files() end";
          desc = "Find Files";
        };

        "<leader>fg" = {
          action.__raw = "function() Snacks.picker.git_files() end";
          desc = "Find Git Files";
        };

        "<leader>fp" = {
          action.__raw = "function() Snacks.picker.projects() end";
          desc = "Find Projects";
        };

        "<leader>fr" = {
          action.__raw = "function() Snacks.picker.recent() end";
          desc = "Find Recent";
        };

        # Git
        "<leader>gb" = {
          action.__raw = "function() Snacks.picker.git_branches() end";
          desc = "Git Branches";
        };

        "<leader>gl" = {
          action.__raw = "function() Snacks.picker.git_log() end";
          desc = "Git Log";
        };

        "<leader>gL" = {
          action.__raw = "function() Snacks.picker.git_log_line() end";
          desc = "Git Log Line";
        };

        "<leader>gs" = {
          action.__raw = "function() Snacks.picker.git_status() end";
          desc = "Git Status";
        };

        "<leader>gS" = {
          action.__raw = "function() Snacks.picker.git_stash() end";
          desc = "Git Stash";
        };

        "<leader>gd" = {
          action.__raw = "function() Snacks.picker.git_diff() end";
          desc = "Git Diff (Hunks)";
        };

        "<leader>gf" = {
          action.__raw = "function() Snacks.picker.git_log_file() end";
          desc = "Git Log File";
        };

        "<leader>sb" = {
          action.__raw = "function() Snacks.picker.lines() end";
          desc = "Buffer Lines";
        };

        "<leader>sB" = {
          action.__raw = "function() Snacks.picker.grep_buffers() end";
          desc = "Grep Open Buffers";
        };

        "<leader>sg" = {
          action.__raw = "function() Snacks.picker.grep() end";
          desc = "Grep";
        };

        "<leader>sw" = {
          mode = ["n" "x"];
          action.__raw = "function() Snacks.picker.grep_word() end";
          desc = "Visual selection or word";
        };

        # Search
        "<leader>s\"" = {
          action.__raw = "function() Snacks.picker.registers() end";
          desc = "Registers";
        };

        "<leader>s/" = {
          action.__raw = "function() Snacks.picker.search_history() end";
          desc = "Search History";
        };

        "<leader>sa" = {
          action.__raw = "function() Snacks.picker.autocmds() end";
          desc = "Autocmds";
        };

        "<leader>sc" = {
          action.__raw = "function() Snacks.picker.command_history() end";
          desc = "Command History";
        };

        "<leader>sC" = {
          action.__raw = "function() Snacks.picker.commands() end";
          desc = "Commands";
        };

        "<leader>sd" = {
          action.__raw = "function() Snacks.picker.diagnostics() end";
          desc = "Diagnostics";
        };

        "<leader>sD" = {
          action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
          desc = "Buffer Diagnostics";
        };

        "<leader>sh" = {
          action.__raw = "function() Snacks.picker.help() end";
          desc = "Help Pages";
        };

        "<leader>sH" = {
          action.__raw = "function() Snacks.picker.highlights() end";
          desc = "Highlights";
        };

        "<leader>si" = {
          action.__raw = "function() Snacks.picker.icons() end";
          desc = "Icons";
        };

        "<leader>sj" = {
          action.__raw = "function() Snacks.picker.jumps() end";
          desc = "Jumps";
        };

        "<leader>sk" = {
          action.__raw = "function() Snacks.picker.keymaps() end";
          desc = "Keymaps";
        };

        "<leader>sl" = {
          action.__raw = "function() Snacks.picker.loclist() end";
          desc = "Location List";
        };

        "<leader>sm" = {
          action.__raw = "function() Snacks.picker.marks() end";
          desc = "Marks";
        };

        "<leader>sM" = {
          action.__raw = "function() Snacks.picker.man() end";
          desc = "Man Pages";
        };

        "<leader>sq" = {
          action.__raw = "function() Snacks.picker.qflist() end";
          desc = "Quickfix List";
        };

        "<leader>sR" = {
          action.__raw = "function() Snacks.picker.resume() end";
          desc = "Resume";
        };

        "<leader>su" = {
          action.__raw = "function() Snacks.picker.undo() end";
          desc = "Undo History";
        };

        "<leader>ss" = {
          action.__raw = "function() Snacks.picker.lsp_symbols() end";
          desc = "LSP Symbols";
        };

        "<leader>sS" = {
          action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
          desc = "LSP Workspace Symbols";
        };

        "gd" = {
          action.__raw = "function() Snacks.picker.lsp_definitions() end";
          desc = "Goto Definition";
        };

        "gD" = {
          action.__raw = "function() Snacks.picker.lsp_declarations() end";
          desc = "Goto Declaration";
        };

        "gr" = {
          action.__raw = "function() Snacks.picker.lsp_references() end";
          desc = "References";
        };

        "gI" = {
          action.__raw = "function() Snacks.picker.lsp_implementations() end";
          desc = "Goto Implementation";
        };

        "gy" = {
          action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
          desc = "Goto T[y]pe Definition";
        };
      };

      flash = mkList {
        "s" = {
          mode = ["n" "x" "o"];
          action.__raw = "function() require('flash').jump() end";
          desc = "Flash";
        };
        "S" = {
          mode = ["n" "x" "o"];
          action.__raw = "function() require('flash').treesitter() end";
          desc = "Flash Treesitter";
        };
        "r" = {
          mode = ["o"];
          action.__raw = "function() require('flash').remote() end";
          desc = "Remote Flash";
        };
        "R" = {
          mode = ["o" "x"];
          action.__raw = "function() require('flash').treesitter_search() end";
          desc = "Treesitter Search";
        };
        "<m-s>" = {
          mode = ["c"];
          action.__raw = "function() require('flash').toggle() end";
          desc = "Toggle Flash";
        };
      };

      trouble = mkList {
        "<leader>xx" = {
          action = "<cmd>Trouble diagnostics toggle<cr>";
          desc = "Diagnostics";
        };
        "<leader>xQ" = {
          action = "<cmd>Trouble qflist toggle<cr>";
          desc = "Quickfix List";
        };
        "<leader>xL" = {
          action = "<cmd>Trouble loclist toggle<cr>";
          desc = "Location List";
        };
        "<leader>xd" = {
          action = "<cmd>Trouble lsp toggle focus = false win.position=right<cr>";
          desc = "LSP Definitions / references / ...";
        };
      };

      sidekick = mkList {
        "<tab>" = {
          action.__raw = ''
            function()
              if not require("sidekick").nes_jump_or_apply() then
                return "<Tab>"
              end
            end
          '';
          desc = "GoTo/Apply Next Edit Suggestion";
        };
        "<c-.>" = {
          mode = ["n" "t" "i" "x"];
          action.__raw = "function() require('sidekick').toggle() end";
          desc = "Sidekick Toggle";
        };
        "<leader>aa" = {
          action.__raw = "function() require('sidekick.cli').toggle() end";
          desc = "Sidekick CLI Toggle";
        };
      };

      noice = mkList {
        "<leader>n" = {
          action = "<cmd>Noice dismiss<cr>";
          desc = "Dismiss all notifications";
        };
      };
    in
      config.lib.nixvim.keymaps.mkKeymaps {} (lib.concatLists [
        general
        yazi
        none-ls
        snacks
        flash
        trouble
        sidekick
        noice
      ]);
  };
}
