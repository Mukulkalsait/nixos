{ config, pkgs, ... }:

{
  networking.hostName = "browser-vm";

  microvm = {
    hypervisor = "qemu";

    vcpu = 2;
    mem = 3072;

    volumes = [
      {
        mountPoint = "/";
        image = "root.img";
        size = 8192; # 8GB
      }
    ];



    shares = [
      {
        source = "/nix/store";
        mountPoint = "/nix/store";
        tag = "ro-store";
        proto = "virtiofs";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    tor-browser-bundle-bin
  ];

  services.getty.autologinUser = "root";
}

