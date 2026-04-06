{ pkgs, ... } : {

  home.username = "pizzakat";
  home.homeDirectory = "/home/pizzakat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " "

      vim.keymap.set('i', 'jk', '<ESC>')
      vim.keymap.set('i', 'kj', '<ESC>')

      vim.keymap.set('n', '<leader>w', ':w<CR>')
      vim.keymap.set('n', '<leader>q', ':q<CR>')

      vim.opt.number = true;
      vim.opt.relativenumber = true;
      vim.opt.shiftwidth = 2;
      vim.opt.expandtab = true;
    '';
    };  

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = true;
      update_check_interval = 0;
      background_opacity = 0.9;
      confirm_os_window_close = 0;
    };
  };

  home.packages = [
    pkgs.jetbrains.idea-ultimate
  ];

  home.file.".ideavimrc".text = ''
    "" --- Keybindings (Syncing with your Neovim) ---
    let mapleader = " "

    " Fast exit from insert mode
    inoremap jk <Esc>
    inoremap kj <Esc>

    " Save and Quit (Mapping to IntelliJ Actions)
    " nnoremap <leader>w <Action>(SaveAll)
    " nnoremap <leader>q <Action>(CloseContent)

    "" --- Quality of Life ---
    set number
    set relativenumber
    set ideajoin      " Use IntelliJ's smart join logic
    set ideaput      " Use IntelliJ's clipboard logic
    set surround     " Enables vim-surround support
    set hlsearch
    set ignorecase
    set smartcase
  '';

}
