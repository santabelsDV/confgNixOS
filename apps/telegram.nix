{ config, pkgs, lib, ... }:

let
  # Імпортуємо нестабільний канал
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = with pkgs; 
  [
    unstable.telegram-desktop  
  ];
}