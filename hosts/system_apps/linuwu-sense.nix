# Y: PREDATOR Sense Solution In NixOs
{ pkgs, lib, ... }:

let
  kernel = pkgs.linuxPackages_latest.kernel;
  linuwu-sense = pkgs.stdenv.mkDerivation rec {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06";

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "main";
      sha256 = "sha256-qznkPBxPFyjJBcMF0EyIWiU8x0ZMKSDJDMzJMFGmg/0=";
    };

    nativeBuildInputs = with pkgs; [ pkg-config kmod gcc gnumake ];
    buildInputs = [ kernel.dev ];

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
      echo "Installed module to: $out/lib/modules/${kernel.modDirVersion}/extra/linuwu_sense.ko"
    '';

    postInstall = ''
      ${pkgs.kmod}/bin/depmod -a -b $out ${kernel.modDirVersion}
      echo "Ran depmod for kernel ${kernel.modDirVersion}"
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
  boot.blacklistedKernelModules = [ "acer_wmi" ];
  boot.postBootCommands = ''
    ${pkgs.kmod}/bin/depmod -a ${kernel.modDirVersion} # Y: Update module deps
    find /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/ -type f -exec chmod 666 {} \; 2>/dev/null || true # Y: Fix sysfs permissions
    echo '3,1,100,2,0,0,0' | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode #Y: RGB Set
    echo '1' | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter # Y: Battery Limiter
    echo "Applied Linuwu-Sense tweaks ( Bat80 & RGB )"
  '';
}
