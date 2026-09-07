# greetd.nix

# { config, pkgs, ... }:
#
# {
#   services.greetd = {
#     enable = true;
#     settings = {
#       default_session = {
#         # command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '☣ Danger : PredatorNix ☣' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd ${pkgs.hyprland}/bin/Hyprland";
#         command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '☣ Danger : PredatorNix ☣' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd ${config.programs.hyprland.package}/bin/Hyprland";
#         user = "greeter";
#       };
#     };
#   };
#
#   # Ensure XDG_RUNTIME_DIR exists for greeter
#   systemd.tmpfiles.rules = [
#     "d /run/user/999 0700 greeter greeter -"
#   ];
# }


# greetd.nix
# Y: Greetd Display Manager Configuration
#    Edit the `greeterConfig` block below for anything you want to change.
#    Nothing past that point needs touching for day-to-day tweaks.
{ config, lib, pkgs, ... }:

let
  greeterUid = 999;

  greeterConfig = {
    greeting = "☣ Danger : PredatorNix ☣";
    showTime = true;
    rememberLastUser = true;
    asterisksForPassword = true;

    # Y: any key here becomes a tuigreet `--theme` entry, add/remove freely
    theme = {
      border = "magenta";
      text = "cyan";
      prompt = "green";
      time = "red";
      action = "blue";
      button = "yellow";
      container = "black";
      input = "red";
    };

    # Y: directories tuigreet scans for selectable sessions (arrow keys to switch).
    #    hyprland.desktop and steam.desktop both land here automatically —
    #    Hyprland from programs.hyprland, Steam gaming session from
    #    programs.steam.gamescopeSession.enable in nvidia.nix.
    sessionDirs = [
      "/run/current-system/sw/share/wayland-sessions"
    ];
  };

  # ---- wiring below, no need to edit for normal tweaks ----

  themeString = lib.concatStringsSep ";"
    (lib.mapAttrsToList (k: v: "${k}=${v}") greeterConfig.theme);

  sessionsPath = lib.concatStringsSep ":" greeterConfig.sessionDirs;

  tuigreetFlags = lib.concatStringsSep " " (
    lib.optional greeterConfig.showTime "--time"
    ++ lib.optional greeterConfig.asterisksForPassword "--asterisks"
    ++ lib.optional greeterConfig.rememberLastUser "--remember"
    ++ [
      "--greeting '${greeterConfig.greeting}'"
      "--theme '${themeString}'"
      "--sessions '${sessionsPath}'"
    ]
  );
in
{
  users.users.greeter.uid = lib.mkDefault greeterUid;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet ${tuigreetFlags}";
      user = "greeter";
    };
  };

  systemd.tmpfiles.rules = [
    "d /run/user/${toString greeterUid} 0700 greeter greeter -"
  ];
}
