{ pkgs, ... }:
{

  programs.nixvim = {

    extraPackages = with pkgs; [
      nixfmt
      black
      clang-tools
      google-java-format
      typstyle
      prettier
      kotlin-language-server
      ktlint
    ];

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox.enable = true;

    globals = {
      mapleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
      background = "dark";
    };

    keymaps = [
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
      }
      {
        mode = "i";
        key = "kj";
        action = "<ESC>";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>gb"; # "gb" for Git Blame
        action = "<cmd>Gitsigns blame_line<CR>";
      }
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
      }
      {
        mode = "n";
        key = "<leader>tl"; # Space + t + l (Terminal List)
        action = "<cmd>TermSelect<CR>";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>Rest run<CR>";
        options.desc = "Run HTTP request under cursor";
      }
    ];

    plugins = {

      web-devicons.enable = true;
      luasnip.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
          };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
        };
        extensions = {
          ui-select.enable = true;
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      nvim-autopairs = {
        enable = true;
      };

      lsp = {
        enable = true;

        servers = {
          ts_ls.enable = true;
          nixd.enable = true;

          # Web
          html.enable = true;
          cssls.enable = true;

          # Python
          pyright.enable = true;

          # C/C++
          clangd.enable = true;

          # Java
          jdtls.enable = true;
          jdtls.extraOptions = {
            settings = {
              java = {
                configuration = {
                  runtimes = [
                    {
                      name = "JavaSE-21";
                      path = "/nix/store/4sc7bszs7fkhlvi07x7ywfq3nhsa0w31-openjdk-21.0.10+7/lib/openjdk";
                    }
                  ];
                };
              };
            };
          };

          # Kotlin
          kotlin-language-server.enable = true;

          # Typst
          tinymist.enable = true;
        };

        keymaps = {
          # Diagnostic keymaps (for navigating errors/warnings)
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };

          # Buffer keymaps (actions you take on the code itself)
          lspBuf = {
            "gd" = "definition"; # Go to definition
            "gr" = "references"; # Find all references
            "K" = "hover"; # Show documentation/types (Shift+k)
            "<leader>rn" = "rename"; # Rename variable across entire project
            "<leader>ca" = "code_action"; # Auto-fix/Code actions
          };
        };
      };

      cmp = {
        enable = true;
        settings = {
          # Where to pull suggestions from (Order matters! Top is highest priority)
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];

          # Keybindings for navigating the dropdown menu
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()"; # Manually trigger the menu (Ctrl+Space)
            "<C-e>" = "cmp.mapping.abort()"; # Close the menu without choosing
            "<CR>" = "cmp.mapping.confirm({ select = true })"; # Enter to select
            "<Tab>" = "cmp.mapping.select_next_item()"; # Go down the list
            "<S-Tab>" = "cmp.mapping.select_prev_item()"; # Go up the list (Shift+Tab)
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];

            nix = [ "nixfmt" ];
            python = [ "black" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            java = [ "google-java-format" ];
            kotlin = [ "ktlint" ];
            typst = [ "typstyle" ];
          };

          format_on_save = {
            # If a specific formatter isn't found, use the LSP's basic formatter
            lsp_fallback = true;
            timeout_ms = 2000;
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          # Set Ctrl+t as the default keymap to open floating terminals
          open_mapping = "[[<C-t>]]";
          direction = "float"; # Makes it pop up in the middle of the screen
          float_opts = {
            border = "curved";
          };
        };
      };

      gitsigns = {
        enable = true;

        settings = {
          # OPTIONAL BUT AWESOME: Turns on virtual inline git blame
          # It shows a faded "You, 2 hours ago • Added express route"
          # at the end of the specific line your cursor is currently on.
          current_line_blame = true;
        };
      };

      neo-tree = {
        enable = true;

        # Highly recommended default:
        # If Neo-tree is the last window open, close Neovim instead of hanging.
        settings = {
          close_if_last_window = true;
        };

      };

      rest = {
        enable = true;
      };
    };

  };
}
