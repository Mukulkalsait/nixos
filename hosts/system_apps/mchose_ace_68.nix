{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666", GROUP="plugdev"
  '';

  # Optional: make sure `plugdev` exists and your user is in it
  users.groups.plugdev = { };
  users.users.mukuldk.extraGroups = [ "plugdev" ];
}

