{ config, lib, pkgs, inputs, ... }:

# DX: temporary workaround start =>
let
  qtPrivateOverlay = self: super: {
    libfm-qt = super.libfm-qt.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
        super.qt6Packages.qtbase.dev # Includes private headers
      ];
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DQT_ENABLE_PRIVATE_HEADERS=ON" ];
    });

    pcmanfm-qt = super.pcmanfm-qt.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
        super.qt6Packages.qtbase.dev # Includes private headers
      ];
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DQT_ENABLE_PRIVATE_HEADERS=ON" ];
    });
  };
in
# DX: temporary workaround end =|

{
  nixpkgs.overlays = [ qtPrivateOverlay ]; # DX: temporary workaround extra line

  imports = [
    ./hardware-configuration.nix # Y: Hardware Config.
    ./system_apps # Y: ROOT FILES |>

    inputs.home-manager.nixosModules.default
  ];

  # IMP: Flakes + Kernal
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Flake:
  nixpkgs.config.allowUnfree = true; # Use latest kernel.

  # IMP: TimeZone.
  time.timeZone = "Asia/Kolkata"; # TimeZone.

  # IMP: INPUT METHODS + input Selector
  i18n.defaultLocale = "en_US.UTF-8"; # Input Method.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-m17n # Hindi/Marathi transliteration
      fcitx5-gtk # GTK apps
      libsForQt5.fcitx5-qt # Qt5 apps
      qt6Packages.fcitx5-qt # Qt6 apps
    ];
  };


  # DX: don not change after this --------------------------------------------------------------------------------------------------------------------------------|
  #
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?


  # --- Nix daemon: max-jobs = 1, use /nix/tmp as build temp ---
  nix.settings = {
    sandbox = true;
    max-jobs = 1;
    cores = 0;
    trusted-users = [ "root" "@wheel" ];
  };

  # Use /nix/tmp as temporary build directory (replaces invalid tmp-dir)
  environment.variables.TMPDIR = "/nix/tmp";

  # Create large persistent /nix/tmp on every boot
  systemd.tmpfiles.rules = [
    "d /nix/tmp 1777 root root 30d"
  ];

}
