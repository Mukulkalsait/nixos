# /etc/nixos/hosts/system_apps/linuwu-sense_kernal_fixed.nix
# Y: PREDATOR Sense – kernel 6.17.2, debug stripped, clean build

{ pkgs, lib, ... }:

let
  # -----------------------------------------------------------------
  # 1. Custom kernel – 6.17.2 + debug/BTF disabled
  # -----------------------------------------------------------------
  customKernel = (pkgs.linux_6_17.override {
    argsOverride = rec {
      version = "6.17.2";
      modDirVersion = "6.17.2";

      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
        sha256 = "/evLBlBl9cG43Gim+1nNpQzd2/kQPSB8IZbVXqdk9X8=";
      };

      # ---- TURN OFF EVERYTHING THAT BLOWS UP TEMP SPACE ----
      structuredExtraConfig = with lib.kernel; {
        DEBUG_INFO = no;
        DEBUG_INFO_BTF = no;
        DEBUG_INFO_DWARF5 = no;
        DEBUG_INFO_REDUCED = no;
        BPF = no;
        BPF_SYSCALL = no;
        MODULE_COMPRESS_NONE = yes;
      };
    };
  }).overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      make mrproper
    '';
  });

  # -----------------------------------------------------------------
  # 2. linuwu-sense module
  # -----------------------------------------------------------------
  linuwu-sense = pkgs.stdenv.mkDerivation rec {
    pname = "linuwu-sense";
    version = "unstable-2025-09-06";

    src = pkgs.fetchFromGitHub {
      owner = "0x7375646F";
      repo = "Linuwu-Sense";
      rev = "df84ac7a020efebd4cd1097e73940d93eb959093";
      sha256 = "sha256-vSvNaSzd5Q8nXBGjYXaXcM4k924QV54x9UgKiFLMBVs=";
    };

    postPatch = ''
      sed -i 's|KDIR  := /lib/modules/$(KVER)/build|KDIR  := $(KERNELDIR)|' Makefile
    '';

    nativeBuildInputs = with pkgs; [ pkg-config kmod gcc gnumake ];
    buildInputs = [ customKernel.dev ];

    makeFlags = [
      "KERNELDIR=${customKernel.dev}/lib/modules/${customKernel.modDirVersion}/build"
    ];

    preBuild = ''
      if [ ! -d "${customKernel.dev}/lib/modules/${customKernel.modDirVersion}/build" ]; then
        echo "Error: Kernel build directory not found"
        exit 1
      fi
      export MODULES_DIR=${customKernel.dev}/lib/modules/${customKernel.modDirVersion}
    '';

    buildPhase = ''make $makeFlags M=$(pwd) all'';
    installPhase = ''
      install -D src/linuwu_sense.ko \
        $out/lib/modules/${customKernel.modDirVersion}/extra/linuwu_sense.ko
    '';

    meta = with lib; {
      description = "Acer Predator fan/RGB/turbo/battery control";
      license = licenses.gpl2Only;
      platforms = platforms.linux;
    };
  };
in
{
  # -----------------------------------------------------------------
  # 3. System integration
  # -----------------------------------------------------------------
  boot.kernelPackages = pkgs.linuxPackagesFor customKernel;
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
        "${pkgs.writeShellScript "linuwu-four-zone" ''
          echo "3,1,100,2,0,0,0" | tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode
        ''}"
        "${pkgs.writeShellScript "linuwu-battery-limit" ''
          echo "1" | tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter
        ''}"
      ];
    };
  };
}

