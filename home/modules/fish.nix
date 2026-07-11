# Fish shell конфігурація
{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Вимикаємо стандартне вітальне повідомлення
      set -g fish_greeting ""

      # Direnv інтеграція
      direnv hook fish | source
    '';

    shellAliases = {
      ll = "ls -l --color=auto";
      la = "ls -la --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";

      # Nix/NixOS швидкі команди
      rebuild = "sudo nixos-rebuild switch --flake ~/config#nixos";
      rebuild-test = "sudo nixos-rebuild test --flake ~/config#nixos";
      flake-up = "nix flake update --flake ~/config";

      # Git швидкі команди
      gs = "git status -sb";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      gl = "git log --oneline --graph --decorate -20";
    };

    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

  # Direnv інтеграція (автоматично завантажує .envrc / flake.nix)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
