{ pkgs, lib, ... }:

let
  kernel = pkgs.linuxPackages_latest.kernel; # Reference the running kernel
  linuwu-sense = pkgs.stdenv.mkDerivation rec {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06";

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "main"; # Or a specific commit hash for reproducibility
      sha256 = "sha256-qznkPBxPFyjJBcMF0EyIWiU8x0ZMKSDJDMzJMFGmg/0=";
    };

    nativeBuildInputs = with pkgs; [ pkg-config kmod gcc gnumake ];
    buildInputs = [ kernel.dev ]; # Kernel development files

    makeFlags =
      [ "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

    preBuild = ''
      echo "Kernel directory: ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      ls -ld ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build || echo "Kernel build directory not found"
      export MODULES_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}
    '';

    buildPhase = ''
      runHook preBuild
      make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
      runHook postBuild
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
      cp src/linuwu_sense.ko $out/lib/modules/${kernel.modDirVersion}/extra/
    '';

    postInstall = ''
      # Ensure module dependencies are updated
      ${pkgs.kmod}/bin/depmod -a -b $out ${kernel.modDirVersion}
    '';

    meta = with lib; {
      description =
        "Kernel module for Acer Predator fan/RGB/turbo/battery control";
      license = licenses.gpl2;
      platforms = platforms.linux;
    };
  };
in {
  boot.extraModulePackages = [ linuwu-sense ];
  boot.kernelModules = [ "linuwu_sense" ];
  boot.blacklistedKernelModules =
    [ "acer_wmi" ]; # Prevents conflicts with stock module
}
