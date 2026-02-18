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

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true; # Display manager
  services.xserver.displayManager.defaultSession = "none+openbox";

  services.xserver.windowManager.openbox.enable = true;
  services.xserver.libinput.enable = true; # keyboard input

  services.getty.autologinUser = "null"; # primarrly set to root.

  users.users.tor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    password = "asdf";
  };

  environment.systemPackages = with pkgs; [
    tor-browser
    xterm
  ];

}

