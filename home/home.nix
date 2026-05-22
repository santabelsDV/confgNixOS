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
    pkgs.onedrive
    pkgs.onedrivegui

    #Трей 
    pkgs.gnomeExtensions.appindicator

    # Додано пакет розширення Clipboard Indicator (Буфер обміну)
    pkgs.gnomeExtensions.clipboard-indicator

    # Годиник робочий стіл
    pkgs.gnomeExtensions.desktop-clock

    # Додано пакет розширення Vitals та утиліти для зчитування сенсорів
    pkgs.gnomeExtensions.vitals
    pkgs.libgtop
    pkgs.lm_sensors
    pkgs.sysstat


    pkgs.gnomeExtensions.forge

    pkgs.gnomeExtensions.random-wallpaper


  ];

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "grp:alt_shift_toggle" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "hidetopbar@mathieu.bidon.ca"
        "caffeine@patapon.info"
        "hibernate-status@dromi"
        "appindicatorsupport@rgcjonas.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "desktop-clock@rmy.pobox.com"
        "forge@jmmaranan.com"
        "randomwallpaper@iflow.space"
      ];
    };
  };

  programs.home-manager.enable = true;
}