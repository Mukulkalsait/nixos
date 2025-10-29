# Y: Nvidia + Gaming Setup.
{ config, pkgs, ... }: {
  # Y: x.server = OpenGL :
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      cudatoolkit
      nvidia-vaapi-driver
      ocl-icd
      opencl-headers
    ];
    # Uncomment if you need 32-bit OpenCL (Proton/Wine/Resolve plugins)
    # extraPackages32 = with pkgs.pkgsi686Linux; [
    #   ocl-icd
    #   opencl-headers
    # ];
  };

  # Y: NVIDIA: 
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false; # Use proprietary for CUDA
    nvidiaPersistenced = false; #  DX: Turned off because breaking GPU.= {basically keep nvidia running} / we are fine without it.

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

  # Y: GAME MODE
  programs.gamemode.enable = true;

  # Y: STEAM 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

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

   # hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
   #   ocl-icd
   #   opencl-headers
   # ];
*/

