{ config, pkgs, lib, ... }:

let
  # Імпортуємо нестабільний канал
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{programs.steam = {
  enable = true;
};
}
