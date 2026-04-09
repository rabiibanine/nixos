{
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
  };
}
