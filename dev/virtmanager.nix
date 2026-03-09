{ pkgs,lib, ... }:
{
  # Вмикаємо libvirtd для керування віртуалізацією
 
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };
  # Вмикаємо virt-manager (це також автоматично налаштує dconf для збереження налаштувань)
  programs.virt-manager.enable = true;

  # Додаємо користувача до необхідних груп для роботи без sudo
  users.users.sasha = {
    isNormalUser = true;
    extraGroups = [  "fuse" ];
  };

environment.etc."fuse.conf".text = ''
  user_allow_other
'';
}