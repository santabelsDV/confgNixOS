{
  description = "NixOS конфігурація Sasha";

  inputs = {
    # Стабільний nixpkgs (замінює root-канал nixos)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Unstable nixpkgs (замінює <nixos-unstable>)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager (замінює user-канал home-manager)
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen Browser (замінює fetchTarball + flake-compat хак)
    zen-browser.url = "github:youwen5/zen-browser-flake";

    # Noctalia Shell — desktop shell для Wayland (бар, лаунчер, нотифікації тощо)
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, noctalia, ... }:
  let
    system = "x86_64-linux";

    # Overlay: додає pkgs.unstable.* для доступу до нестабільних пакетів
    unstableOverlay = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit zen-browser noctalia;
      };

      modules = [
        # Прокидаємо unstable через overlay
        { nixpkgs.overlays = [ unstableOverlay ]; }

        # Системна конфігурація
        ./configuration.nix
        ./zen.nix
        ./niri.nix
        noctalia.nixosModules.default

        # Home Manager як NixOS-модуль
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sasha = import ./home/home.nix;
        }
      ];
    };
  };
}
