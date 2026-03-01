{ config, pkgs, ... }:

{
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.zip
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.hide-top-bar
    pkgs.gnomeExtensions.caffeine
    pkgs.gnome-shell-extensions
    pkgs.gnomeExtensions.hibernate-status-button
    pkgs.gnome-tweaks
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "hidetopbar@mathieu.bidon.ca"
        "caffeine@patapon.info"
        "hibernate-status@dromi"
      ];
    };
  };

  programs.home-manager.enable = true;
}