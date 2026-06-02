# Y: TUI Login manager.
#
# { config, pkgs, ... }: {
#
#   services.greetd = {
#     enable = true;
#     settings = {
#       default_session = {
#         command =
#           "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '☣ Danger : PredatorNix ☣' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd Hyprland";
#         user = "greeter";
#       };
#     };
#   };
# }

{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '☣ Danger : PredatorNix ☣' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };
    };
  };

  # Ensure XDG_RUNTIME_DIR exists for greeter
  systemd.tmpfiles.rules = [
    "d /run/user/999 0700 greeter greeter -"
  ];
}
