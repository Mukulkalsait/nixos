{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --remember --greeting '  Welcome to PredatorNix  ' --theme prompt=green text=white time=yellow input=bright-blue error=red selected=magenta --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}

