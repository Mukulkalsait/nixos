# Y: Hardware Services
{ config, pkgs, ... }: {

  # G:  Networking.

  networking = {
    hostName = "PredatorNix"; # Define your hostname.
    networkmanager.enable = true;
    enableIPv6 = true; # newly added
  };

  # G:  Bluetooth.
  hardware.bluetooth.enable = true; # Enable Bluetooth
  services.blueman.enable = true; # optional: nice GTK tray app

  # G: Sensors.
  hardware.i2c.enable = true; # Enable sensors.

  # Y: THUNDERBOLT
  services.hardware.bolt.enable = true; # Bolt daemon:Thunderbolt
  services.udev.packages =
    [ pkgs.bolt ]; # Optional:udevRules BetterDeviceHandling.

  # R: i dont know if its really for thunderbolt or powerprofilectl command. => or use "tlp"
  services.power-profiles-daemon.enable =
    true; # better Thunderbolt  power management

  # Y:  Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true; 

  # Y: Sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # alsa.support32bit = true; # does not exisists;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = false; # Y: CUPS => print documents.
  # services.modemmanager.enable = false; Y: variable not avialable error.
}

