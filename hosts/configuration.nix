{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Y: Hardware Config.
      ./system_apps/user.nix
      ./system_apps/git.nix
      ./system_apps/greetd.nix
      ./system_apps/nvidia.nix

      inputs.home-manager.nixosModules.default
      # ./system_apps/disabled.nix # Y: Unused lines moved here
    ];


  # Flake: 
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "PredatorNix"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     # alsa.support32bit = true; # does not exisists;
     pulse.enable = true;
     jack.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true; 

  # DX: don not change after this --------------------------------------------------------------------------------------------------------------------------------|
  #
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

