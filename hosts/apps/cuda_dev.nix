# hosts/apps/cuda_development.nix
{ pkgs, ... }: {
  # Add the CUDA packages strictly to your user profile
  home.packages = with pkgs; [
    cudatoolkit
    cudaPackages.cudnn
    linuxPackages_latest.perf # For profiling your custom CUDA code
    gcc # Host compiler for CUDA nvcc nvcc
  ];

  # Set up the precise environment flags inside your user shell session
  home.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };

  # Automatically inject path variables into your Zsh environment
  programs.zsh.initExtra = ''
    export LD_LIBRARY_PATH="${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudatoolkit}/lib:$LD_LIBRARY_PATH"
  '';
}

