{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Y: Hardware Config.
    ./system_apps/user.nix
    ./system_apps/git.nix
    ./system_apps/greetd.nix
    ./system_apps/nvidia.nix
    ./system_apps/linuwu-sense.nix
    ./system_apps/mchose_ace_68.nix

    inputs.home-manager.nixosModules.default
    # ./system_apps/disabled.nix # Y: Unused lines moved here
  ];

  # Flake: 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8; # keep only last 8 entries
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.editor = false; # optional: hide editor

  # Use latest kernel.
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Enable Kernal MODULES Thunderbolt USB ec_sys<for fan contorl>
  boot.kernelModules = [ "thunderbolt" "usb_storage" "uas" "ec_sys" ];
  # Enable Kernal parameters 
  boot.kernelParams = [ "acpi_ec.gpe_debug=1" ];

  networking.hostName = "PredatorNix"; # Define your hostname.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # Enable Bluetooth
  services.blueman.enable = true; # optional: nice GTK tray app

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # alsa.support32bit = true; # does not exisists;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = false; # Enable CUPS to print documents.
  # services.modemmanager.enable = false; Y: variable not avialable error.

  # Y: THUNDERBOLT
  services.hardware.bolt.enable = true;
  # Enable Bolt daemon for Thunderbolt device management
  services.udev.packages = [ pkgs.bolt ];
  # Optional: Add udev rules for better device handling
  services.power-profiles-daemon.enable = true; # or use tlp
  # For better power management of Thunderbolt devices

  virtualisation.docker = {
    enable = true; # service enabled
    enableOnBoot = false; # systemctl service stoped
  };

  users.users.mukuldk.extraGroups = [ "docker" ]; # group add to user.

  # Y: (Optional) Podman alongside Docker.
  # virtualisation.podman.enable = true;
  # virtualisation.podman.enableOnBoot = false;
  # virtualisation.podman.dockerCompat = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true; 

  # Y : Mchose extras
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666"
  '';

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

