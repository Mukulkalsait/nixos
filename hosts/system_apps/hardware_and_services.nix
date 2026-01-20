# Y: Hardware Services
{ pkgs, ... }: {

  # G:  Networking and DNS resolver.
  services.resolved = {
    enable = true; # This gives Local stub dns-resolver at 127.0.0.53 by systemd
    # R: Local DNS stub is => application{ Local library of DNS+IP }=> that saves time + cpu + RECURSOVE-RESOLVATION ⭐ in local mashine.
  };
  environment.etc."systemd/resolved.conf.d/00-custom.conf".text = ''
    [Resolve]
    DNSStubListener=yes
    DNSSEC=no
    DNSOverTLS=no
  '';

  networking = {
    hostName = "PredatorNix"; # Define your hostname.
    enableIPv6 = true; # newly added
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved"; # For custome DNS=> by systemd.resolver 👇
    nameservers = [
      "1.1.1.1" # Cloudflare
      "1.0.0.1"
      "8.8.8.8" # Google (fallback)
      "8.8.4.4"
    ];
  };
  # ----------------------------
  #
  # G:  Bluetooth.
  hardware.bluetooth.enable = true; # Enable Bluetooth
  services.blueman.enable = true; # optional: nice GTK tray app

  # G: Sensors.
  hardware.i2c.enable = true; # Enable sensors.

  # Y: THUNDERBOLT
  services.hardware.bolt.enable = true; # Bolt daemon:Thunderbolt
  services.udev.packages =
    [ pkgs.bolt ]; # Optional:udevRules BetterDeviceHandling.

  # Y: Battery Indicator may be.
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true; # better Thunderbolt power management
  # 👆🏻 thunderbolt or powerprofilectl command. => or use "tlp"
  services.dbus.enable = true;
  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "HybridSleep";
  };
  services.logind = {
    lidSwitch = "suspend";
    settings.Login = {
      HandlePowerKey = "ignore";
      HandleSuspendKey = "suspend";
      HandleHibernateKey = "hibernate";
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";
    };
  };


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

