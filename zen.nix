{ config, pkgs, ... }:

let
  flake-compat = import (builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz");
  
  # Використовуємо master замість main
  zen-src = builtins.fetchTarball "https://github.com/youwen5/zen-browser-flake/archive/master.tar.gz";
  
  zen-browser = (flake-compat { src = zen-src; }).defaultNix;
in
{
  environment.systemPackages = [
    zen-browser.packages."${pkgs.system}".default
  ];
}