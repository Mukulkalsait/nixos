{ config, pkgs, ... }: {
  # NVIDIA: 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
      # Y: bash
      # lspci | grep -i vga
      # 0000:00:02.0 VGA compatible controller: Intel Corporation Alder Lake-S [UHD Graphics] (rev 0c)
      # 0000:01:00.0 VGA compatible controller: NVIDIA Corporation AD107M [GeForce RTX 4050 Max-Q / Mobile] (rev a1)
    };
    # package = pkgs.linuxPackages.nvidia_x11; # Ensure latest NVIDIA driver
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    stress-ng # cpu stress tests
    blender # blender tests
    mangohud # fps overlay
    steam
    protonup
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '')
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/mukuldk/.steam/root/compatibilitytools.d";
  };
}

/* G: command avialable
   ------------------------
       nvidia-offload <game>
       nvidia-offload <cmd>
       gamemodrun  <cmd>
       mangohud <cmd>
       gamescope <cmd>
*/

