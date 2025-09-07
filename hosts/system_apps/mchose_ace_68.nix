# Y:  MChose Config Suporter.
{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666", GROUP="plugdev"
  '';

  # # Y: this were ther in configuraion.nix
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666"
  # '';

  # Optional: make sure `plugdev` exists and your user is in it
  users.groups.plugdev = { };
  users.users.mukuldk.extraGroups = [ "plugdev" ];
}

