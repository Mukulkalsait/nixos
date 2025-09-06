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
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = false;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0"; # Matches 00:02.0
      nvidiaBusId = "PCI:1:0:0"; # Matches 01:00.0
    };
  };
}

