{ config, pkgs, lib, ... }:
{

  programs.steam = {
  enable = true;
};
  environment.systemPackages = with pkgs; [
    (texlive.withPackages (ps: with ps; [
      ps.scheme-medium
      ps.collection-langcyrillic
      ps.multirow              # ← додай цей рядок
    ]))
    biber
    (python3.withPackages (ps: with ps; [
      pygments
    ]))
  ];
}