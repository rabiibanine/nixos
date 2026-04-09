{ pkgs, ... }:
{

  home.username = "pizzakat";
  home.homeDirectory = "/home/pizzakat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

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

    profiles.pizzakat = {

      id = 0;
      name = "pizzakat";
      isDefault = true;

      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";

        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always-show";
      };

    };

    policies = {

      ExtensionSettings = {

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
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

  home.packages = with pkgs; [

    # Applications
    jetbrains.idea
    zathura

    # Tools
    zip
    unzip
    ripgrep
    bat
    jq
    btop
    fastfetch
    wl-clipboard

    # GNOME Apps & Tools
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    dconf-editor

  ];

  home.shellAliases = {
    # --- THE SYSTEM REBUILD ALIAS ---

    switch = "sudo nixos-rebuild switch --flake ~/.config/nixos/";

    # --- SYSTEM MAINTENANCE ---

    cleanup = "sudo nix-collect-garbage -d";
    update = "nix flake update ~/.config/nixos/";
    conf = "cd ~/.config/nixos/";
    home = "cd ~";
    "edit-home" = "nvim ~/.config/nixos/home.nix";
    "edit-config" = "nvim ~/.config/nixos/configuration.nix";

    # --- MODERN CLI SWAPS ---

    # --- FILE NAVIGATION ALIASES ---

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
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "kitty.desktop"
      ];

    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {

      blur = true;
      whitelist = [ "kitty" ];
      unblur = false;
      brightness = 0.6;

    };

  };

}
