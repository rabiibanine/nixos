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
      

  home.packages = [
    pkgs.jetbrains.idea-ultimate
  ];

}
