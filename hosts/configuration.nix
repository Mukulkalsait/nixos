{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Y: Hardware Config.
    ./system_apps # Y: ROOT FILES |>

    inputs.home-manager.nixosModules.default
  ];

  # IMP: Flakes + Kernal
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Flake:
  nixpkgs.config.allowUnfree = true; # Use latest kernel.

  # IMP: TimeZone.
  time.timeZone = "Asia/Kolkata"; # TimeZone.
  i18n.defaultLocale = "en_US.UTF-8"; # Input Method.

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

