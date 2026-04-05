{ pkgs,lib, ... }:
let
  # Імпортуємо нестабільний канал
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  
  environment.systemPackages = with pkgs; [
  libreoffice

  # Перевірка орфографії (Hunspell) та словники
  unstable.hunspell
  unstable.hunspellDicts.uk_UA
  unstable.hunspellDicts.en_US
  unstable.liberation_ttf
  unstable.corefonts

  
];

fonts.packages = with pkgs; [
    unstable.corefonts      # Містить MS шрифти: Times New Roman, Arial, Courier New тощо
    
  ];
}