{ config, pkgs, ... }:

let
  cozylife = pkgs.buildHomeAssistantComponent {
    owner = "imatrixcz";
    domain = "hass_cozylife_local_pull";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "imatrixcz";
      repo = "hass_cozylife_local_pull";
      rev = "master";
      sha256 = "0902h555qsinsadvnaxqx4b1hxwa9zzpirax2383wlbjsd2yqpkn";
    };
    postPatch = ''
      sed -i 's/self._attr_color_mode = ColorMode.COLOR_TEMP/self._attr_color_mode = list(self._attr_supported_color_modes)[0] if self._attr_supported_color_modes else ColorMode.ONOFF/g' custom_components/hass_cozylife_local_pull/light.py
      sed -i 's/time.sleep(3)/for _ in range(150):\n        if all(item.device_type_code != str for item in hass.data[DOMAIN]["tcp_client"]):\n            break\n        time.sleep(0.1)/g' custom_components/hass_cozylife_local_pull/__init__.py
    '';
  };
in
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "met"
      "google_translate"
      "upnp"
      "radio_browser"
    ];
    customComponents = [ cozylife ];
    config = {
      # Включає стандартні залежності для базового налаштування
      default_config = {};
      
      # Налаштування веб-сервера
      http = {
        server_port = 8123;
        server_host = "0.0.0.0";
      };

      # Налаштування CozyLife
      hass_cozylife_local_pull = {
        lang = "en";
        # Автоматичний пошук часто не працює через віртуальні інтерфейси Linux, 
        # тому надійніше використовувати Static IP у роутері:
        ip = [ "192.168.31.182" ];
      };
    };
  };

  # Дозволяємо користувачу sasha вмикати/вимикати Home Assistant без пароля
  security.sudo.extraRules = [
    {
      users = [ "sasha" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl start home-assistant.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl stop home-assistant.service";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Створюємо кнопку (ярлик) у меню програм
  environment.systemPackages = [
    (pkgs.makeDesktopItem {
      name = "home-assistant-toggle";
      desktopName = "Перемикач Home Assistant";
      exec = pkgs.writeShellScript "toggle-hass" ''
        if /run/current-system/sw/bin/systemctl is-active --quiet home-assistant.service; then
          sudo /run/current-system/sw/bin/systemctl stop home-assistant.service
          ${pkgs.libnotify}/bin/notify-send -t 2000 "Home Assistant" "🔴 Сервіс ВИМКНЕНО"
        else
          sudo /run/current-system/sw/bin/systemctl start home-assistant.service
          ${pkgs.libnotify}/bin/notify-send -t 2000 "Home Assistant" "🟢 Сервіс УВІМКНЕНО"
        fi
      '';
      icon = "system-run"; # Стандартна іконка
      categories = [ "Utility" ];
    })
  ];
}
