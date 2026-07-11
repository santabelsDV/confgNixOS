{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice
    unstable.hunspell
    unstable.hunspellDicts.uk_UA
    unstable.hunspellDicts.en_US
    unstable.liberation_ttf
    unstable.corefonts
    python3Packages.litellm
  ];

  fonts.packages = with pkgs; [
    unstable.corefonts
    unstable.liberation_ttf
  ];
}