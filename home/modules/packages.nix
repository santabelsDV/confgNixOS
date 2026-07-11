# Користувацькі пакети (встановлюються через Home Manager)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Шрифти
    nerd-fonts.fira-code

    # Файловий менеджер
    superfile

    # Хмарне сховище
    onedrive
    onedrivegui

    # Утиліти
    zip
    htop
    ripgrep
    fd
    bat          # cat з підсвіткою синтаксису
    eza          # сучасна заміна ls
    fzf          # нечіткий пошук

    # Git delta (потрібен для git.nix)
    delta
  ];

  # bat як заміна cat
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Mocha";
  };
  # eza як заміна ls
  programs.eza = {

    enable = true;
    icons = "auto";
    git = true;
  };

  # fzf — нечіткий пошук (Ctrl+R для історії)
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
