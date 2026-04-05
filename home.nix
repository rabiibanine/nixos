{ pkgs, ... } : {

  home.username = "pizzakat";
  home.homeDirectory = "/home/pizzakat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
  };

  home.packages = [
    pkgs.jetbrains.idea-ultimate
  ];

}
