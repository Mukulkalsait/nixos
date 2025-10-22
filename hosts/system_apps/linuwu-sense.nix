# Y: PREDATOR Sense Solution In NixOs (chat gpt version)

{ pkgs, lib, ... }:

let
  kernel = pkgs.linuxPackages_latest.kernel;

  linuwu-sense = pkgs.stdenv.mkDerivation rec {
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

    buildPhase = ''
      echo ">>> Building Linuwu Sense against kernel ${kernel.modDirVersion}"
      make \
        KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
        KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
        all
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
      find . -name '*.ko' -exec install -Dm644 {} \
        $out/lib/modules/${kernel.modDirVersion}/extra/ \;
    '';

    meta = with lib; {
      description = "Kernel module for Acer Predator fan/RGB/turbo/battery control";
      license = licenses.gpl2Only;
      platforms = platforms.linux;
      maintainers = [ "mukuldk" ];
    };
  };
in
{
  boot.extraModulePackages = [ linuwu-sense ];
  boot.kernelModules = [ "linuwu_sense" ];
  boot.blacklistedKernelModules = [ "acer_wmi" ];

  systemd.services.linuwu-sense-setup = {
    description = "Apply Linuwu-Sense tweaks (RGB + Battery limiter)";
    wantedBy = [ "multi-user.target" ];
    after = [ "sys-module-linuwu_sense.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = [
        "${pkgs.findutils}/bin/find /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/ -type f -exec chmod 660 {} +"
        "${pkgs.findutils}/bin/find /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/ -type f -exec chgrp wheel {} +"
        "${pkgs.bash}/bin/sh -c 'echo \"3,1,100,2,0,0,0\" | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode'"
        "${pkgs.bash}/bin/sh -c 'echo \"1\" | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter'"
      ];
    };
  };
}

