{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      cuda = pkgs.cudaPackages;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ cuda.cudatoolkit cuda.backendStdenv.cc pkgs.perf ];
        shellHook = ''
          export CUDA_HOME=${cuda.cudatoolkit}
          export CUDA_PATH=${cuda.cudatoolkit}
          export CUDACXX=${cuda.cudatoolkit}/bin/nvcc
          export LD_LIBRARY_PATH=/run/opengl-driver/lib:${cuda.cudatoolkit}/lib:$LD_LIBRARY_PATH
        '';
      };
    };
}
