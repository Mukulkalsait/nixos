{ config, pkgs, ... }:

{
  networking.hostName = "kamehameha";

  microvm = {
    hypervisor = "qemu";
    vcpu = 2; # 2cpu
    mem = 3072; # 3Gb
    graphics.enable = true;
    shares = [ ];
    volumes = [{
      mountPoint = "/";
      image = "root.img";
      size = 8192; # 8GB
    }];
    interfaces = [{
      type = "user";
      id = "vmnat0";
      mac = "02:00:00:00:00:01";
    }];

    # TMPFS = FS in TMP folder 
    # fileSystems."/" = {
    #   device = "tmpfs";
    #   fsType = "tmpfs";
    # };
  };

  # Networking
  services.resolved.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.useNetworkd = true;
  networking.useDHCP = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    extraCommands = ''
      iptables -A OUTPUT -m owner --uid-owner tor -j ACCEPT
      iptables -A OUTPUT -d 127.0.0.1  -j ACCEPT
      iptables -A OUTPUT -j REJECT

    '';
  };

  # Display
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true; # Display manager
  services.displayManager.defaultSession = "none+openbox";

  services.xserver.windowManager.openbox.enable = true;
  services.libinput.enable = true; # keyboard input

  services.getty.autologinUser = "null"; # primarrly set to root.
  services.tor = { enable = true; client.enable = true; };

  users.users.toruser = {
    isNormalUser = true;
    description = "Tor Browser User";
    extraGroups = [ "video" ];
    password = "asdf";
  };

  environment.systemPackages = with pkgs; [
    tor-browser
    xterm
  ];

}

