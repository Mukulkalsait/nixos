# Y:  define the users
{ config, pkgs, ... }: {

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8; # Keep Recent 8 Entries.
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.editor = false; # optional: hide editor

  boot.kernelPackages = pkgs.linuxPackages_latest; # latest Kernal Pkg. # DX: kernal selector but its inside Linuvu-sense*.nix
  boot.kernelModules = [
    # Y:  Enable Kernal MODULES

    "thunderbolt" # thunderbolt
    "usb_storage" # usb
    "uas" # dont know
    "ec_sys" # EC fan controls.
  ];
  boot.kernelParams = [ "acpi_ec.gpe_debug=1" ]; # Enable Kernal parameters

}

