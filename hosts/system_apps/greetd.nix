# Y: TUI Login manager.
{ config, pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '☣ Danger : PredatorNix ☣' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
