# hosts/apps/cuda_dev.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Y: Use the modern explicit toolkit components to avoid license block collisions
    cudaPackages.cuda_nvcc # The core compiler (nvcc)
    cudaPackages.cuda_cudart # CUDA Runtime libs
    cudaPackages.cudnn # Deep learning libraries

    # linuxPackages_latest.perf # For profiling your custom CUDA code 
    pkgs.perf
    gcc # Host compiler for CUDA nvcc
  ];

  home.sessionVariables = {
    # Dynamically find the path of whichever package wraps the nvidia driver
    CUDA_PATH = "${pkgs.cudaPackages.cuda_nvcc}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };

  # Fix: Changed initExtra to initContent to clear your evaluation warning!
  programs.zsh.initContent = ''
    export LD_LIBRARY_PATH="${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cuda_cudart}/lib:$LD_LIBRARY_PATH"
  '';
}
