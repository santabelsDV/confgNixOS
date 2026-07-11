{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.unstable.telegram-desktop
  ];
}