{ config, pkgs, ... }:

{
  imports =
    [
      <home-manager/nixos> 
    ];

  # Оптимізація: наказуємо Home Manager використовувати системну версію Nixpkgs
  # Це економить місце на диску і час збірки
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Конфігурація середовища для вашого користувача
  home-manager.users.sasha = { pkgs, ... }: {
    
    # 1. Встановлення програм ТІЛЬКИ для sasha
    home.packages = with pkgs; [
      
      zip
      
    ];   

    programs.bash = {
      enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch";
        ll = "ls -alF";
      };
    };

    # 3. Версія стану Home Manager (має збігатися з system.stateVersion)
    home.stateVersion = "25.11";
  };

}