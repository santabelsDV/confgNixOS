# Niri — scrollable tiling Wayland compositor
# Додає сесію Niri до GDM (GNOME залишається)
{ pkgs, ... }:

{
  # Вмикаємо Niri як додаткову сесію
  programs.niri.enable = true;

  # Noctalia Shell
  programs.noctalia = {
    enable = true;
  };

  # Сервіси потрібні для Noctalia (батарея, bluetooth)
  services.upower.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
