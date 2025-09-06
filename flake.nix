{
  description = "Mukul's NixOS with Hyprland and Home Manager";

  inputs = {
    # Use unstable for latest packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #  Neovim NIGHTLY OVERLAY
    # neovim-nightly-overlay = { url = "github:nix-community/neovim-nightly-overlay"; };

    # YAZI:
    # yazi.url = "github:sxyazi/yazi";

  };

  outputs = { self, nixpkgs, home-manager, hyprland, zen-browser, nbfc-linux
    , ... }@inputs:
    let
      # Y: VARIALBES =>
      system = "x86_64-linux";
      # pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      # pkgs = import nixpkgs { inherit system; };

    in {
      nixosConfigurations.PredatorNix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          user = "mukuldk";
        };
        modules = [
          ./hosts/configuration.nix

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
        ];
      };
    };
}
