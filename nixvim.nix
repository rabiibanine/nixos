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

    };

  };
}
