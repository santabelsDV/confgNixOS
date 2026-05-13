{ config, pkgs, ... }:

{
  # Вмикаємо інтеграцію KDE Connect через розширення GSConnect для GNOME
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Додаємо менеджер розширень для зручного увімкнення GSConnect
  environment.systemPackages = with pkgs; [
    gnome-extension-manager
  ];
}