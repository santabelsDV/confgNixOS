# Niri — конфігурація через Home Manager
# Файл config.kdl та додаткові пакети для Niri сесії
{ pkgs, ... }:

{
  # Конфігурація Niri (config.kdl)
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;

  # Скрипт перемикання герцовки для Niri
  home.file.".local/bin/toggle-hz-niri" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      CURRENT=$(niri msg outputs | grep -oP '\d+\.\d+(?= Hz \(current\))' | head -1)
      HZ=''${CURRENT%%.*}

      if [[ "$HZ" -le 65 ]]; then
        niri msg output eDP-1 mode 2560x1600@165.002
        notify-send -a "Дисплей" -t 2000 "🔄 Герцовка" "165 Hz"
      else
        niri msg output eDP-1 mode 2560x1600@60.000
        notify-send -a "Дисплей" -t 2000 "🔄 Герцовка" "60 Hz"
      fi
    '';
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Додаткові пакети для Niri сесії
  home.packages = with pkgs; [
    wl-clipboard       # Буфер обміну в Wayland
    brightnessctl       # Керування яскравістю
    playerctl           # Керування медіа
    grim                # Скріншоти
    slurp               # Вибір області для скріншоту
    quickshell          # QML shell
    xwayland-satellite  # XWayland для X11-додатків (Steam тощо)
  ];
}
