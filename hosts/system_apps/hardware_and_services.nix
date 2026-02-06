# Y: Hardware Services
{ pkgs, ... }: {
  # G:  Networking and DNS resolver.
  services.resolved = { enable = true; };
  # R: Local DNS stub is => application{ Local library of DNS+IP }=> that saves time + cpu + RECURSOVE-RESOLVATION ⭐ in local mashine.

  environment.etc."systemd/resolved.conf.d/00-custom.conf".text = ''
    [Resolve]
    DNSStubListener=yes
    DNSSEC=no
    DNSOverTLS=no
  '';

  networking = {
    hostName = "PredatorNix"; # our Hostname
    enableIPv6 = true;
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved"; # CostumeDNS => systemd.resolver
    nameservers = [
      "1.1.1.1" # Cloudfare
      "1.0.0.1"
      "8.8.8.8" # google (fallback)
      "8.8.4.4"
    ];
  };

  # G: Bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # gtx tray app.

  # G: Sensors.
  hardware.i2c.enable = true; # enable sensors.

  # Y: THUNDERBOLT
  services.hardware.bolt.enable = true; #BOLT daemon Thunderbold
  services.udev.packages = [ pkgs.bolt ]; #UDEV.Rules battery device handling.

  # Y: POWER MANAGEMENT - FIXED
  powerManagement.enable = true;

  # DX: REMOVE this - it conflicts with proper battery management
  # services.power-profiles-daemon.enable = true;  # REMOVE THIS LINE

  # Use TLP instead for better power management
  services.tlp = {
    enable = true;
    settings = {
      # Battery thresholds (won't work on your hardware, but doesn't hurt)
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;

      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Enable audio power saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  services.dbus.enable = true;

  # UPower configuration - CORRECTED
  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "PowerOff"; # Changed to PowerOff for reliability
  };

  # Logind settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";

    settings.Login = {

      HandlePowerKey = "ignore";
      HandleSuspendKey = "suspend";
      HandleHibernateKey = "hibernate";

      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";

      IdleAction = "ignore";
      IdleActionSec = "30min";
    };
  };


  # Y:  Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true; 

  # Y: Sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = false;
} 
