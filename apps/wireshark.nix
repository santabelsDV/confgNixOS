{ config, pkgs, lib, ... }:

{
 # environment.systemPackages = with pkgs; [
 #   wireshark
 # ];
#
 # programs.wireshark = {
 #   enable = true;
 #   dumpcap.enable = true;
 # };

 # users.users.sasha = {
  #  isNormalUser = true;
 #   extraGroups = [ "networkmanager" "wheel" "wireshark" ];
 # };


 # 1. Увімкнення модуля Wireshark
  # Це створить необхідні SUID-обгортки для dumpcap
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  # 2. Додавання користувача до відповідної групи
  # Тільки користувачі в групі 'wireshark' можуть захоплювати пакети
  users.users.sasha.extraGroups = [ "wireshark" ];
}
