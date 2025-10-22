# Y: PREDATOR Sense Solution In NixOs

{ pkgs, lib, config, ... }:

let
  kernel = config.boot.kernelPackages.kernel;
  kernelPackages = config.boot.kernelPackages;
  linuwu-sense = pkgs.stdenv.mkDerivation {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06";

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "df84ac7a020efebd4cd1097e73940d93eb959093";
      sha256 = "sha256-vSvNaSzd5Q8nXBGjYXaXcM4k924QV54x9UgKiFLMBVs=";
    };

    nativeBuildInputs = with pkgs; [ pkg-config kmod gcc gnumake ];
    buildInputs = [ kernel.dev ];

    makeFlags = [
      "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    ];

    installPhase = ''
      install -D src/linuwu_sense.ko $out/lib/modules/${kernel.modDirVersion}/extra/linuwu_sense.ko
    '';

    meta = with lib; {
      description = "Kernel module for Acer Predator fan/RGB/turbo/battery control";
      license = licenses.gpl2Only;
      platforms = platforms.linux;
    };
  };
in
{
  boot.extraModulePackages = [ linuwu-sense ];
  boot.kernelModules = [ "linuwu_sense" ];
  boot.blacklistedKernelModules = [ "acer_wmi" ];
}

