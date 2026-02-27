{ pkgs,lib, ... }:
{
  environment.systemPackages = with pkgs; [
  libreoffice

  # Перевірка орфографії (Hunspell) та словники
  hunspell
  hunspellDicts.uk_UA
  hunspellDicts.en_US
  liberation_ttf
  corefonts

  
];

fonts.packages = with pkgs; [
    corefonts      # Містить MS шрифти: Times New Roman, Arial, Courier New тощо
    
  ];
}