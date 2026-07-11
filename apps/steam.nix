{ config, pkgs, lib, ... }:
{

programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Опціонально: для Steam Remote Play
    dedicatedServer.openFirewall = true; # Опціонально: для Source Dedicated Server
  };
  
  environment.systemPackages = with pkgs; [
    (texlive.withPackages (ps: with ps; [
      ps.scheme-medium
      ps.collection-langcyrillic
      ps.multirow              # ← додай цей рядок
    ]))
    biber
  ];
}