You're right, and I was wrong to point at nixpkgs first. Your `nvidia.nix` is clean: it has no CUDA, and your flake already includes `cache.nixos-cuda.org`, so my substituter tip was redundant.

The CUDA is coming from `cuda_dev.nix`. It's imported into `home.nix`, so `cudaPackages.cudatoolkit` sits in `home.packages` and gets built on every rebuild. The error log shows the chain:

`cuda_cuxxfilt` → `cuda-merged-12.9` → `home-manager-path` → `home-manager-generation` → the whole system

`cuda-merged-12.9` is the `cudatoolkit` symlink-join. Home Manager's path pulls it in, so a CUDA build failure blocks your whole rebuild. Your nixpkgs bump from yesterday probably also changed the CUDA derivations. The cache may not have that revision yet, so it built locally and hit the bug.

**Fix: take CUDA out of the system build**

1. In `home.nix`, comment out the `./apps/cuda_dev.nix` import (or whatever path you use).
2. Run `snrsf` again. The `cuxxfilt` failure should disappear, and you don't need to roll back nixpkgs.

If something still pulls CUDA in after that, find out what with:

```bash
nix why-depends /etc/nixos#nixosConfigurations.PredatorNix.config.system.build.toplevel \
  nixpkgs#cudaPackages.cudatoolkit
```

Other packages, like an `ollama` or `btop` built with CUDA support, are common culprits.

**Use CUDA only when you need it**

Make a separate small flake, for example `~/cuda-shell/flake.nix`:

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      cuda = pkgs.cudaPackages;
    in {
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
```

Then run `nix develop ~/cuda-shell` when you want CUDA. It's only fetched or built the first time and lives in the store until garbage collection, and your system rebuilds never touch it.

I used `cuda.backendStdenv.cc` instead of plain `gcc` on purpose. Your log shows gcc 16, and nvcc 12.9 doesn't support a compiler that new, so the CUDA-compatible one is the safer choice.

If you'd like to keep the same shell setup for one project, you can put the same `devShells` block in that project's flake instead.
