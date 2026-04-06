# Y:  MChose Config Suporter.
{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="powercap", KERNEL=="intel-rapl:*", MODE="0444"
  '';

  # # EXPLANATION 
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="41e4", ATTRS{idProduct}=="2116", MODE="0666"
  #
  #   B: used for RAPL permission so that mangohood can read it the cpu wattage/gpu0 data
  #   SUBSYSTEM=="powercap", KERNEL=="intel-rapl:*", MODE="0444" => 

  # Optional: make sure `plugdev` exists and your user is in it
  users.groups.plugdev = { };
  users.users.mukuldk.extraGroups = [ "plugdev" ];
}

