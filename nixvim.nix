{ config, pkgs, ... } : {

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox.enable = true;

    globals = { mapleader = " "; };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
      background = "dark";
    };

    keymaps = [
      { mode = "i"; key = "jk"; action = "<ESC>"; }
      { mode = "i"; key = "kj"; action = "<ESC>"; }
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; }
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; }
    ];

    plugins = {

      web-devicons.enable = true;
      luasnip.enabe = true;

      lualine = {
        enable = true;
        settings = {
          options = { icons_enabled = true; };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
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
        };

        keymaps = {
          # Diagnostic keymaps (for navigating errors/warnings)
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };

          # Buffer keymaps (actions you take on the code itself)
          lspBuf = {
            "gd" = "definition";         # Go to definition
            "gr" = "references";         # Find all references
            "K"  = "hover";              # Show documentation/types (Shift+k)
            "<leader>rn" = "rename";     # Rename variable across entire project
            "<leader>ca" = "code_action";# Auto-fix/Code actions
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
            "<C-e>" = "cmp.mapping.abort()";        # Close the menu without choosing
            "<CR>" = "cmp.mapping.confirm({ select = true })"; # Enter to select
            "<Tab>" = "cmp.mapping.select_next_item()";   # Go down the list
            "<S-Tab>" = "cmp.mapping.select_prev_item()"; # Go up the list (Shift+Tab)
          };
        };
      };

    };

  };
}
