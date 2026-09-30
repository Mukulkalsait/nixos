# hosts/apps/cuda_dev.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    cudaPackages.cudatoolkit
    # cudaPackages.cudnn
    perf
    gcc
  ];

  home.sessionVariables = {
    CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
    CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    CUDACXX = "${pkgs.cudaPackages.cudatoolkit}/bin/nvcc";
  };

  home.sessionPath = [
    "${pkgs.cudaPackages.cudatoolkit}/bin"
  ];

  programs.zsh.initContent = ''
    export LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH"
  '';
}
