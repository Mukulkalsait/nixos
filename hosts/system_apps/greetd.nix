{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
  };

  programs.tuigreet = {
    enable = true;
    settings = {
      default_session = {
      command = "tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
      };
    };
  };
}

