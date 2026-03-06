# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,lib, ... }:

let
  # Імпортуємо нестабільний канал
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apps/default.nix
      ./dev/default.nix
    ];

    

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 6;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_UA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.displayManager.sddm.enable = false;
  
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sasha = {
    isNormalUser = true;
    description = "Sasha";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Вказуємо використовувати пропрієтарний драйвер
  services.xserver.videoDrivers = [ "nvidia" ];

  # Дозволяємо встановлення пропрієтарних програм (необхідно для NVIDIA, Discord, Steam тощо)
  nixpkgs.config.allowUnfree = true;

  # Вмикаємо підтримку графічного прискорення (OpenGL/Vulkan)
  hardware.graphics.enable = true;
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # 3. Виправлена спеціалізація
  specialisation = {
   gaming.configuration = {
      system.nixos.tags = [ "gaming" ];
      
      hardware.nvidia = {
        powerManagement.enable = lib.mkForce false;
        powerManagement.finegrained = lib.mkForce false;
        
        prime = {
          # ПОВНЕ вимкнення Offload для ігрового режиму
          offload.enable = lib.mkForce false;
          offload.enableOffloadCmd = lib.mkForce false;
          # Примусовий Sync (всі вікна малює NVIDIA)
          sync.enable = lib.mkForce true;
        };
      };
      
      # Додамо glxinfo для перевірки саме в цей режим (або в загальний)
      environment.systemPackages = [ pkgs.mesa-demos pkgs.pciutils ];
    };
    open-driver-test.configuration = {
      system.nixos.tags = [ "open-driver-test" ];
      
      hardware.nvidia = {
        # Примусово вмикаємо відкриті модулі ядра
        open = lib.mkForce true; 
        
        # Примусово вмикаємо глибоке енергозбереження (D3cold)
        powerManagement.enable = lib.mkForce true;
        powerManagement.finegrained = lib.mkForce true;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # gnome soft
  services.gnome.gnome-software.enable = true;

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     unstable.vscode

     unstable.rar
     unstable.unrar
     unstable.peazip
     gau
     sqlmap 
     wget
     mesa-demos
     pciutils
     nvtopPackages.full
     

     vesktop
     nodejs_24
     brave
     git
     gdm-settings
     gnome-randr
     xorg.xrandr
     libnotify
     steam


     vulkan-loader
     vulkan-validation-layers
     vulkan-tools
     
     (bottles.override { removeWarningPopup = true; })
     (writeShellScriptBin "toggle-hz" ''
       #!/usr/bin/env bash

       # --- НАЛАШТУВАННЯ ---
       DISPLAY_NAME="eDP-1"
       
       WAYLAND_LOW_MODE="2560x1600@60.000"
       WAYLAND_HIGH_MODE="2560x1600@165.002"
       
       X11_RES="2560x1600"
       X11_LOW_HZ="60"
       X11_HIGH_HZ="165"
       # --------------------

       if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
         # Виправлено: тепер шукаємо частоту за зірочкою (*), як вона реально виводиться
         CURRENT=$(gnome-randr | grep "\*" | grep -oP '\d+(?=\.\d+\*)' | head -n 1)
         
         # Запобіжник: якщо не вдалося зчитати частоту
         if [[ -z "$CURRENT" ]]; then
           notify-send -a "Дисплей" -u critical "Помилка" "Не вдалося визначити поточну герцовку"
           exit 1
         fi

         if [[ "$CURRENT" -le 65 ]]; then
           gnome-randr modify "$DISPLAY_NAME" --mode "$WAYLAND_HIGH_MODE"
           notify-send -a "Дисплей" -t 2000 "🔄 Герцовка змінена" "Встановлено 165 Hz (Wayland)"
         else
           gnome-randr modify "$DISPLAY_NAME" --mode "$WAYLAND_LOW_MODE"
           notify-send -a "Дисплей" -t 2000 "🔄 Герцовка змінена" "Встановлено 60 Hz (Wayland)"
         fi

       else
         # Логіка для X11
         CURRENT=$(xrandr | grep "\*" | grep -oP '\d+(?=\.\d+\*)' | head -n 1)
         
         if [[ -z "$CURRENT" ]]; then
           notify-send -a "Дисплей" -u critical "Помилка" "Не вдалося визначити поточну герцовку"
           exit 1
         fi

         if [[ "$CURRENT" -le 65 ]]; then
           xrandr --output "$DISPLAY_NAME" --mode "$X11_RES" --rate "$X11_HIGH_HZ"
           notify-send -a "Дисплей" -t 2000 "🔄 Герцовка змінена" "Встановлено 165 Hz (X11)"
         else
           xrandr --output "$DISPLAY_NAME" --mode "$X11_RES" --rate "$X11_LOW_HZ"
           notify-send -a "Дисплей" -t 2000 "🔄 Герцовка змінена" "Встановлено 60 Hz (X11)"
         fi
       fi
     '')
     
    

  ];



  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16 * 1024; # Вкажіть розмір у мегабайтах (наприклад, 16 ГБ = 16 * 1024)
  } ];

  boot.initrd.systemd.enable = true;
  powerManagement.enable = true;


  environment.etc."xdg/mimeapps.list".text = ''
  [Default Applications]
  text/html=firefox.desktop
  x-scheme-handler/about=firefox.desktop
  x-scheme-handler/http=firefox.desktop
  x-scheme-handler/https=firefox.desktop
'';


environment.sessionVariables = {
    BROWSER = "firefox";
  };

  # 2. Виключаємо Epiphany (вбудований браузер GNOME), щоб він не перехоплював пошук
  environment.gnome.excludePackages = with pkgs; [
    epiphany
  ];






  



  #Автоподшрузка в память (Не актуально)
  #services.preload.enable = true;
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  
   
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
