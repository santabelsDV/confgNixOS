{ pkgs, ... }:
{
    virtualisation.docker.enable = true;

    
    users.users.sasha = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Додаємо docker сюди
  };

  environment.systemPackages = with pkgs; [
    # ... твої інші пакунки ...
    docker-compose
  ];
    
}