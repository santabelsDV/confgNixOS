{ config, pkgs, ... }:

{
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.zip
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnome-shell-extensions
    pkgs.gnome-tweaks
    pkgs.gnomeExtensions.hide-top-bar
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "hidetopbar@mathieu.bidon.ca"
      ];
    };
  };

  programs.home-manager.enable = true;
}