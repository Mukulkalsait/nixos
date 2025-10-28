{
  description = "Mukul's NixOS with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Y:  Use unstable for latest packages
    nur.url = "github:nix-community/NUR"; # Y: NUR packages from ARCH 👏



    # HOME-MANAGER: (*)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland & plugins get from here: (*)
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/Hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Stylix: (*)
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ZEN Browser: 
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

  };

  outputs = { self, nixpkgs, home-manager, hyprland, zen-browser, nur, ... }@inputs:
    let
      # Y: VARIALBES =>
      system = "x86_64-linux";

    in
    {
      nixosConfigurations.PredatorNix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          user = "mukuldk";
        };
        modules = [
          ./hosts/configuration.nix

          # Y: NUR overlay
          { nixpkgs.overlays = [ inputs.nur.overlays.default ]; }

          # Hyperland setup
          {
            programs.hyprland.enable = true;
            programs.hyprland.package = hyprland.packages.${system}.hyprland;
            programs.hyprland.portalPackage =
              hyprland.packages.${system}.xdg-desktop-portal-hyprland;
          }

          # Home-Manager as nixos module.
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mukuldk = import ./hosts/home.nix;
          }

          # {
          #   boot.blacklistedKernelModules = lib.optionals (config.boot.blacklistedKernelModules or [ ]) (x: x != "acer_wmi"); # Or just [] if no other blacklists => Ensure acer-wmi loads (remove any old blacklists)
          #   boot.kernelParams = [ "acer_wmi.predator_v4=1" ]; # Optional: Force Predator v4 detection if needed (for full 5 profiles)
          # }

        ];
      };
    };
}

# test
