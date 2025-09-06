{ pkgs, lib, ... }:

let
  linuwu-sense = pkgs.stdenv.mkDerivation rec {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06";

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "main"; # Or a specific commit hash for reproducibility
      sha256 = "sha256-qznkPBxPFyjJBcMF0EyIWiU8x0ZMKSDJDMzJMFGmg/0=";
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = with pkgs;
      [
        linuxPackages_latest.kernel.dev
      ]; # Use the running kernel's dev package

    makeFlags = [
      "KERNELDIR=${pkgs.linuxPackages_latest.kernel.dev}/lib/modules/${pkgs.linuxPackages_latest.kernel.modDirVersion}/build"
    ];

    installPhase = ''
      mkdir -p $out/lib/modules/${pkgs.linuxPackages_latest.kernel.modDirVersion}/extra
      cp linuwu_sense.ko $out/lib/modules/${pkgs.linuxPackages_latest.kernel.modDirVersion}/extra/
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
