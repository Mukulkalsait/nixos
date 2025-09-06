{ config, pkgs, ... }: {
  # NVIDIA: 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    # enable32bit = true; # does not exisist.
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Explicitly enable nvidia-offload script
      };
      intelBusId = "PCI:0:2:0"; # Matches 00:02.0
      nvidiaBusId = "PCI:1:0:0"; # Matches 01:00.0
    };
    # package = pkgs.linuxPackages.nvidia_x11; # Ensure latest NVIDIA driver
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    stress-ng
    blender
    mangohud # fps overlay
    steam
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '')
  ];
}

