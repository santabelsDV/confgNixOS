# Kitty термінал конфігурація
{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 20;
    };

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      cursor_trail = 1;
      cursor_shape = "beam";
      update_check_interval = 0;
      window_padding_width = 4;
      window_margin = 22;
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      shell = "fish";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
    };

    themeFile = "Catppuccin-Mocha";
  };
}
