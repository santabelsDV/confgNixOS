# GNOME розширення та dconf конфігурація
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Розширення оболонки
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hide-top-bar
    gnomeExtensions.caffeine
    gnome-shell-extensions
    gnomeExtensions.hibernate-status-button
    gnomeExtensions.window-calls
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.desktop-clock
    gnomeExtensions.vitals
    gnomeExtensions.forge
    gnomeExtensions.random-wallpaper

    # Утиліти GNOME
    gnome-tweaks

    # Сенсори для Vitals
    libgtop
    lm_sensors
    sysstat
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
        "window-calls@vanyax.github.io"
      ];
    };
  };
}
