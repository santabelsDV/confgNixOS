{ config, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "met"
      "radio_browser"
    ];
    config = {
      # Включає стандартні залежності для базового налаштування
      default_config = {};
      
      # Налаштування веб-сервера
      http = {
        server_port = 8123;
        server_host = "0.0.0.0";
      };
    };
  };
}
