{ lib, ... }:
{
    environment.systemPackages = with pkgs; [
  libreoffice

  # Перевірка орфографії (Hunspell) та словники
  hunspell
  hunspellDicts.uk_UA
  hunspellDicts.en_US
];
}