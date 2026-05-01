{
  description = "Mukul's NixOS with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Y:  Use unstable for latest packages

    # Y: NUR packages from ARCH 👏
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim Nightly
    # neovim-nightly = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

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

    # Fenix Rust NixOS style
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # microvm
    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ghostty
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    # ZEN Browser: 
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Terraform
    nixpkgs-terraform = {
      url = "github:stackbuilders/nixpkgs-terraform";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wifiTUI:
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  outputs = { self, nixpkgs, home-manager, hyprland, fenix, zen-browser, nur, nixpkgs-terraform, microvm, ... }@inputs:
    let
      # Y: VARIALBES =>
      system = "x86_64-linux";

    in
    {
      nixosConfigurations = {

        PredatorNix = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            user = "mukuldk";
          };
          modules = [
            ./hosts/configuration.nix
            {
              nixpkgs.overlays = [
                nur.overlays.default
                fenix.overlays.default
                # neovim-nightly.overlays.default

                # Overdrive of the broken link in neovim-nightly
                # (final: prev: {
                #   neovim = prev.neovim.overrideAttrs (old: {
                #     postInstall = ''
                #       ${old.postInstall or ""}
                #       rm -f $out/share/applications/nvim.desktop || true
                #       mkdir -p $out/share/nvim
                #       touch $out/share/nvim/rplugin.vim || true
                #     '';
                #   });
                # })
              ];
            } # FLAKE: NUR overlay


            # FLAKE: 
            {
              programs.hyprland.enable = true;
              programs.hyprland.package = hyprland.packages.${system}.hyprland;
              programs.hyprland.portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mukuldk =
                import ./hosts/home.nix;
              home-manager.users.root = { pkgs, inputs, ... }: {
                imports = [ ./hosts/apps/neovim.nix ]; # adjust this path to your actual nvim module
                home.username = "root";
                home.homeDirectory = "/root";
                home.stateVersion = "25.05"; # match whatever is in your home.nix
              };
            }

            # terraform
            # {
            #   nixpkgs = {
            #     overlays = [ inputs.nixpkgs-terraform.overlays.default ];
            #     config.allowUnfree = true;
            #   };
            # }
          ];
        };

        # FLAKE:
        dark-net = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            ./hosts/microvm/dark-net.nix
          ];
        };

      };
    };

}



