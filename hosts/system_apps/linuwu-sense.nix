{ pkgs, lib, ... }:

let
  linuwu-sense = pkgs.stdenv.mkDerivation rec {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06"; # Update to latest commit date if needed

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "main"; # Or a specific commit hash for reproducibility
      sha256 =
        "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # Run `nix-prefetch-github 0x7375646F Linuwu-Sense` to get this
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = with pkgs; [ linuxHeaders ];

    makeFlags = [
      "KERNELDIR=${pkgs.linuxPackages.kernel.dev}/lib/modules/${pkgs.linuxPackages.kernel.modDirVersion}/build"
    ];

    installPhase = ''
      mkdir -p $out/lib/modules/${pkgs.linuxPackages.kernel.modDirVersion}/extra
      cp linuwu_sense.ko $out/lib/modules/${pkgs.linuxPackages.kernel.modDirVersion}/extra/
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
