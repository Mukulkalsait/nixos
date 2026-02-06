# Y:  define the users
{ config, pkgs, ... }: {

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8; # Keep Recent 8 Entries.
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.editor = false; # optional: hide editor

  boot.kernelPackages = pkgs.linuxPackages_latest; # latest Kernal Pkg. # DX: kernal selector but its inside Linuvu-sense*.nix

  # boot.extraModulePackages = [
  #   pkgs.linuxKernel.packages.linux_6_18.acer-wmi-battery # B: Acer kernal module for 6.18 => (⭐) 
  # ];

  boot.kernelModules = [
    # Y:  Enable Kernal MODULES
    "thunderbolt" # thunderbolt
    "usb_storage" # usb
    "uas" # dont know
    "ec_sys" # EC fan controls.
    "acer_wmi_battery" # G: acer battery module to work with  -> (⭐) 
  ];
  boot.kernelParams = [
    "acpi_ec.gpe_debug=1" # Enable Kernal parameters
    "preempt=full" # Enamble PREE_MTP=LOW LETENCY FOR MUSIC PRODUCITON => PREMTP_RT (too poweroful for us.)

    # Y: we dont need zswap because we hve zram which is better for persnol systems. so NO ZSWAP
    # "zswap.enabled=1" # z-swap on
    # "zswap.compressor=lz4" # compressor type = LZ4 => best
    # "zswap.zpool=z3fold" # Efficient memory packing
    # "zswap.max_pool_percent=20" # Caps => limit 20% VVVIMP
  ];

}

