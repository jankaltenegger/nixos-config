let
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
in {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme.__raw = ''
          {
            normal = {
              a = { fg = "${nord0}", bg = "${nord9}" },
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord9}" },
            },
            insert = {
              a = { fg = "${nord0}", bg = "${nord14}" },
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord14}" },
            },
            visual = {
              a = { fg = "${nord0}", bg = "${nord15}" },
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord15}" },
            },
            replace = {
              a = { fg = "${nord0}", bg = "${nord12}" },
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord12}" },
            },
            command = {
              a = { fg = "${nord0}", bg = "${nord13}"},
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord13}" },
            },
            inactive = {
              a = { fg = "${nord0}", bg = "${nord8}" },
              b = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              c = { fg = "${nord6}", bg = "${nord0}" },
              x = { fg = "${nord6}", bg = "${nord1}" },
              y = { fg = "${nord6}", bg = "${nord2}", gui='italic' },
              z = { fg = "${nord0}", bg = "${nord8}" },
            },
          }
        '';

        globalstatus = true;
        disabled_filetypes.statusline = [ "yazi" ];
        always_divide_middle = true;

        component_separators = "";
        section_separators = "";
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [
          # Left Separator
          {
            __unkeyed.__raw = "function() return '' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord3}", bg = "${nord0}" },
                  i = { fg = "${nord3}", bg = "${nord0}" },
                  v = { fg = "${nord3}", bg = "${nord0}" },
                  V = { fg = "${nord3}", bg = "${nord0}" },
                  ["\22"] = { fg = "${nord3}", bg = "${nord0}" },
                  c = { fg = "${nord3}", bg = "${nord0}" },
                  R = { fg = "${nord3}", bg = "${nord0}" },
               }
                return C[m] or { fg = "${nord3}" }
              end
            '';
            padding = 0;
          }
          {
            __unkeyed.__raw = "function() return '' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord3}", bg = "${nord9}" },
                  i = { fg = "${nord3}", bg = "${nord14}" },
                  v = { fg = "${nord3}", bg = "${nord15}" },
                  V = { fg = "${nord3}", bg = "${nord15}" },
                  ["\22"] = { fg = "${nord3}", bg = "${nord15}" },
                  c = { fg = "${nord3}", bg = "${nord13}" },
                  R = { fg = "${nord3}", bg = "${nord12}" },
                }
                return C[m] or { fg = "${nord3}" }
              end
            '';
            padding = 0;
          }
          # Mode
          {
            __unkeyed.__raw = ''
              function()
                local m = vim.fn.mode()
                local ico = ({
                  n = " 🜔 ",
                  i = " 🜄 ",
                  v = " 🜃 ",
                  V = "🜃 🜹",
                  ["\22"] = " 🜁 ",
                  c = " 🜲 ",
                  R = " 🜂 ",
                })[m] or " 🜔 "
                return ico
              end
            '';
            padding = 0;
          }
          # Right Separator
          {
            __unkeyed.__raw = "function() return ' ' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord9}", bg = "${nord2}" },
                  i = { fg = "${nord14}", bg = "${nord2}" },
                  v = { fg = "${nord15}", bg = "${nord2}" },
                  V = { fg = "${nord15}", bg = "${nord2}" },
                  ["\22"] = { fg = "${nord15}", bg = "${nord2}" },
                  c = { fg = "${nord13}", bg = "${nord2}" },
                  R = { fg = "${nord12}", bg = "${nord2}" },
                }
                return C[m] or { fg = "${nord9}" }
              end
            '';
            padding = 0;
          }
        ];

        lualine_b = [
          "filename"
          "diff"
          {
            __unkeyed.__raw = "function() return ' ' end";
            color = {
              fg = "${nord2}";
              bg = "${nord1}";
            };
            padding = 0;
          }
        ];
        lualine_c = [
          {
            __unkeyed.__raw = "function() return '' end";
            color = {
              fg = "${nord3}";
              bg = "${nord1}";
            };
            padding = 0;
          }
          {
            __unkeyed.__raw = "function() return '' end";
            color = {
              fg = "${nord3}";
              bg = "${nord0}";
            };
            padding = 0;
          }
        ];

        lualine_x = [
          {
            __unkeyed.__raw = "function() return '' end";
            color = {
              fg = "${nord3}";
              bg = "${nord0}";
            };
            padding = 0;
          }
          {
            __unkeyed.__raw = "function() return '' end";
            color = {
              fg = "${nord3}";
              bg = "${nord1}";
            };
            padding = 0;
          }
          # Show active language server
          {
            __unkeyed = "lsp_status";
            icon = "";
            color.fg = "${nord6}";
            ignore_lsp = ["null-ls"];
          }
          "filetype"
        ];

        lualine_y = [
          {
            __unkeyed.__raw = "function() return ' ' end";
            color = {
              fg = "${nord2}";
              bg = "${nord1}";
            };
            padding = 0;
          }
        ];

        lualine_z = [
          {
            __unkeyed.__raw = "function() return ' ' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord9}", bg = "${nord2}" },
                  i = { fg = "${nord14}", bg = "${nord2}" },
                  v = { fg = "${nord15}", bg = "${nord2}" },
                  V = { fg = "${nord15}", bg = "${nord2}" },
                  ["\22"] = { fg = "${nord15}", bg = "${nord2}" },
                  c = { fg = "${nord13}", bg = "${nord2}" },
                  R = { fg = "${nord12}", bg = "${nord2}" },
                }
                return C[m] or { fg = "${nord9}" }
              end
            '';
            padding = 0;
          }
          "location"
          {
            __unkeyed.__raw = "function() return '' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord3}", bg = "${nord9}" },
                  i = { fg = "${nord3}", bg = "${nord14}" },
                  v = { fg = "${nord3}", bg = "${nord15}" },
                  V = { fg = "${nord3}", bg = "${nord15}" },
                  ["\22"] = { fg = "${nord3}", bg = "${nord15}" },
                  c = { fg = "${nord3}", bg = "${nord13}" },
                  R = { fg = "${nord3}", bg = "${nord12}" },
               }
                return C[m] or { fg = "${nord3}" }
              end
            '';
            padding = 0;
          }
          {
            __unkeyed.__raw = "function() return '' end";
            color.__raw = ''
              function()
                local m = vim.fn.mode()
                local C = {
                  n = { fg = "${nord3}", bg = "${nord0}" },
                  i = { fg = "${nord3}", bg = "${nord0}" },
                  v = { fg = "${nord3}", bg = "${nord0}" },
                  V = { fg = "${nord3}", bg = "${nord0}" },
                  ["\22"] = { fg = "${nord3}", bg = "${nord0}" },
                  c = { fg = "${nord3}", bg = "${nord0}" },
                  R = { fg = "${nord3}", bg = "${nord0}" },
                }
                return C[m] or { fg = "${nord3}" }
              end
            '';
            padding = 0;
          }
        ];
      };
    };
  };
}
