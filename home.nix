{ pkgs, ... } : {

  home.username = "pizzakat";
  home.homeDirectory = "/home/pizzakat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
    ];
    profiles.default.userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Hard";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
      "editor.fontLigatures" = true;
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
    ];

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

      -- Theme
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    '';
    };  

  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
    settings = {
      hide_window_decorations = "yes";
      scrollback_lines = 10000;
      enable_audio_bell = true;
      update_check_interval = 0;
      background_opacity = 0.6;
      confirm_os_window_close = 0;
    };
  };

  home.packages = [

    # Applications
    pkgs.jetbrains.idea

    # Tools
    pkgs.zip
    pkgs.unzip
    pkgs.ripgrep
    pkgs.bat
    pkgs.jq
    pkgs.btop
    pkgs.fastfetch

    # GNOME Apps & Tools
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.dconf-editor

  ];

  home.shellAliases = {
    # --- THE SYSTEM REBUILD ALIAS ---
    # Replace '~/your-flake-folder' with the actual path to your system config
    switch = "sudo nixos-rebuild switch --flake ~/your-flake-folder";

    # --- SYSTEM MAINTENANCE ---
    # The garbage collection command we talked about
    cleanup = "sudo nix-collect-garbage -d";
    # A quick way to update your flake inputs (like fetching newer package versions)
    update = "nix flake update ~/your-flake-folder";

    # --- MODERN CLI SWAPS ---
    # This tricks your brain into using the new, faster tools without having to unlearn muscle memory
    cat = "bat";
    grep = "rg";
    find = "fd";

    # --- FILE NAVIGATION ALIASES ---
    # Standard shortcuts to save you keystrokes
    ".." = "cd ..";
    "..." = "cd ../..";
    ll = "ls -la";
  };

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

  dconf.settings = {

    "org/gnome/shell" = {

    disable-user-extensions = false;
    enabled-extensions = [ "blur-my-shell@aunetx" ];

    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {

      blur = true;
      whitelist = [ "kitty" "Kitty" ];

    };

  };

}
