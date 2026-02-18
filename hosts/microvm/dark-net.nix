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
  };

  services.getty.autologinUser = "root";

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  environment.systemPackages = with pkgs; [
    tor-browser
    xterm
  ];

}

