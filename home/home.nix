{ config, pkgs, ... }:

{
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

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
    pkgs.gnomeExtensions.window-calls

    # Трей 
    pkgs.gnomeExtensions.appindicatotr

    # Додано пакет розширення Clipboard Indicator (Буфер обміну)
    pkgs.gnomeExtensions.clipboard-indicator

    # Годинник робочий стіл
    pkgs.gnomeExtensions.desktop-clock
    pkgs.nerd-fonts.fira-code

    pkgs.superfile

    # Додано пакет розширення Vitals та утиліти для зчитування сенсорів
    pkgs.gnomeExtensions.vitals
    pkgs.libgtop
    pkgs.lm_sensors
    pkgs.sysstat

    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.random-wallpaper
  ];

  programs.fish = {
    enable = true;
    
    # Скрипт, який виконується при запуску інтерактивної сесії
    interactiveShellInit = ''
      # Вимикаємо стандартне вітальне повідомлення
      set -g fish_greeting ""
    '';

    # Аліаси команд (автоматично генеруються у fish-формат)
    shellAliases = {
      ll = "ls -l --color=auto";
      la = "ls -la --color=auto";
      ".." = "cd ..";
    };

    # Плагіни з nixpkgs
    plugins = [
      {
        # Приклад: зручний плагін для навігації
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        # Тема Tide
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

  programs.kitty = {
    enable = true;
    
    # Налаштування шрифту (переконайся, що шрифт встановлено в системі)
    font = {
      name = "FiraCode Nerd Font"; 
      size = 20;
    };

    # Основні параметри термінала
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      cursor_trail = 1;
      cursor_shape = "beam";
      update_check_interval = 0;
      window_padding_width = 4;
      window_margin = 22; 
      background_opacity = "0.95";

      confirm_os_window_close = 0; # Вимикає попередження при закритті вікна


      shell = "fish";
    };

    # Гарячі клавіші
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
    };
  
    # Задаємо тему
    themeFile = "Catppuccin-Mocha"; 
  };

  fonts.fontconfig.enable = true;
  
  home.sessionVariables = {
    TERMINAL = "kitty";
  };
  
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

  programs.home-manager.enable = true;
}