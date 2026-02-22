{ lib, ... }:

let
  # 1. Зчитуємо весь вміст поточної папки (де лежить цей файл)
  dirContents = builtins.readDir ./.;

  # 2. Фільтруємо вміст: залишаємо тільки файли (.nix), ігноруємо папки та сам default.nix
  nixFiles = lib.filterAttrs (name: type: 
    type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) dirContents;

  # 3. Перетворюємо імена знайдених файлів на відносні шляхи (наприклад, "./firefox.nix")
  paths = lib.mapAttrsToList (name: _: ./. + "/${name}") nixFiles;
in
{
  # Передаємо згенерований список шляхів у стандартний атрибут imports
  imports = paths;
}