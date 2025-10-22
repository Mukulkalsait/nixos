# Y: PREDATOR Sense Solution In NixOs

# Y: PREDATOR Sense Solution In NixOS
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

    # Ensure the Makefile never tries to use /lib/modules paths
    postPatch = ''
      sed -i "s|/lib/modules/\\$(KVER)/build|${kernel.dev}/lib/modules/${kernel.modDirVersion}/build|g" Makefile
      sed -i "s|/lib/modules/\\$(shell uname -r)/build|${kernel.dev}/lib/modules/${kernel.modDirVersion}/build|g" Makefile
    '';

    buildPhase = ''
      make KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
           KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
           M=$(pwd) modules
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
      install -Dm644 src/linuwu_sense.ko $out/lib/modules/${kernel.modDirVersion}/extra/linuwu_sense.ko
    '';

    meta = with lib; {
      description = "Kernel module for Acer Predator fan/RGB/turbo/battery control";
      license = licenses.gpl2Only;
      platforms = platforms.linux;
      maintainers = [ maintainers.yourName or "mukuldk" ];
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
        # Set permissions
        "${pkgs.findutils}/bin/find /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/ -type f -exec chmod 660 {} +"
        "${pkgs.findutils}/bin/find /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/ -type f -exec chgrp wheel {} +"

        # Keyboard RGB mode
        "${pkgs.bash}/bin/sh -c 'echo \"3,1,100,2,0,0,0\" | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode'"

        # Battery limiter
        "${pkgs.bash}/bin/sh -c 'echo \"1\" | ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter'"
      ];
    };
  };
}

