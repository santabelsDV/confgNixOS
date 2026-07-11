# Home Manager — головний файл
# Імпортує всі модулі з home/modules/
{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/kitty.nix
    ./modules/gnome.nix
    ./modules/niri.nix
    ./modules/packages.nix
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.stateVersion = "25.11";
  
  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.home-manager.enable = true;
}