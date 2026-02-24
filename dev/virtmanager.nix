{
  # Вмикаємо libvirtd для керування віртуалізацією
  virtualisation.libvirtd.enable = true;
  
  # Вмикаємо virt-manager (це також автоматично налаштує dconf для збереження налаштувань)
  programs.virt-manager.enable = true;

  # Додаємо користувача до необхідних груп для роботи без sudo
  users.users.sasha.extraGroups = [ "libvirtd" "kvm" ];
}