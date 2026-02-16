{ config, pkgs, ... }:

{
  networking.hostName = "browser-vm";

  microvm = {
    hypervisor = "qemu";

    vcpu = 2;
    memory = 3072;


    volumes = [
      {
        mountPoint = "/";
        image = "root.img";
        size = 8192; # 8GB
      }
    ];



    shares = [ ];
  };

  environment.systemPackages = with pkgs; [
    tor-browser
  ];

  services.getty.autologinUser = "root";
}

