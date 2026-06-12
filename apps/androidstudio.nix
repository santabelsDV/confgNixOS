{ config, pkgs, ... }:

{
  
  # 1. Дозволяємо несвободні пакети та приймаємо ліцензію
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  # 2. Встановлюємо Android Studio у FHS-оточенні
  # Це необхідно для коректної роботи завантажених SDK інструментів
  environment.systemPackages = with pkgs; [
    androidStudioPackages.stable # Сучасний стандартний пакет (вже має FHS-обгортку)
  ];

  # 3. Вмикаємо ADB (Android Debug Bridge) на рівні системи.
  # Це АБСОЛЮТНО НЕОБХІДНО для розпізнавання реального телефону по USB (налаштовує udev rules).
  programs.adb.enable = true;

  # 4. Додаємо користувача до групи adbusers
  # 4. Додаємо користувача до групи adbusers
  # Групи kvm та libvirtd прибрані, оскільки емулятор не використовується
  users.users.sasha = {
    extraGroups = [ "adbusers" ];
  };
}