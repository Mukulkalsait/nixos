{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --asterisks \
            --user-menu \
            --greeting "Welcome to PredatorNix 🚀" \
            --theme border=cyan \
            --theme prompt=green \
            --theme text=white \
            --theme time=yellow \
            --theme input=bright-blue \
            --theme error=red \
            --theme selected=magenta \
            --cmd Hyprland
        '';
      };
    };
  };
}

