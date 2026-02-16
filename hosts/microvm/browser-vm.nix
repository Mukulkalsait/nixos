{ config, pkgs, ... }:

{
  networking.hostName = "browser-vm";

  microvm = {
    hypervisor = "qemu";

    vcpu = 2;
    mem = 2048;

    volumes = [
      {
        mountPoint = "/var";
        size = 2048;
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

