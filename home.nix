{ inputs, pkgs, ... }:
{

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  home.username = "pizzakat";
  home.homeDirectory = "/home/pizzakat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      new-project() {
        mkdir -p $2 && cd $2 && nix flake init -t /home/pizzakat/.config/nix-templates#$1
      }
    '';
  };

  programs.starship = {
    enable = true;

    settings = {
      username.show_always = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
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

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisablePocket = true;
    };

    profiles.default = {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
      };

      containersForce = true; # Delete containers not declared here
      containers = {
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 1;
        };
      };

      spacesForce = true; # Delete spaces not declared here
      spaces = {
        "Exploration" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
        };
        "Development" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
          container = 1;
        };
      };

      pinsForce = true; # Delete pins not declared here
      pins = {
        "GitHub" = {
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          url = "https://github.com";
          position = 101;
        };
      };

    };
  };

  # Just in case
  /*
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
  */

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

    # Applications | Temp disable packet tracer and jetbrains
    zathura

    # Tools
    zip
    unzip
    ripgrep
    bat
    jq
    fd
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
    program = "cd ~/Programming/";
    "edit-home" = "nvim ~/.config/nixos/home.nix";
    "edit-config" = "nvim ~/.config/nixos/configuration.nix";
    "get-rev" = "jq -r '.nodes.nixpkgs.locked.rev' /home/pizzakat/.config/nixos/flake.lock";
    "copy-rev" = "jq -r '.nodes.nixpkgs.locked.rev' /home/pizzakat/.config/nixos/flake.lock | wl-copy";

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
        "idea.desktop"
        "org.pwmt.zathura.desktop"
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
