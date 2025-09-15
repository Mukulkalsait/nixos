# Y: Waybar = Notification Bar.
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin-top = 0;
        position = "top";
        height = 10;
        exclusive = true;
        passthrough = false;
        reload_style_on_change = true;
        modules-left = [ "clock" "cpu" "memory" "temperature" ];
        modules-center = [ "hyprland/workspaces" "hyprland/window" ];
        modules-right = [ "tray" "pulseaudio" "network" "backlight" "battery" ];

        "clock" = {
          format = "{:%I:%M %p}";
          rotate = 0;
          format-alt = "{:%R udb80udced %du00b7%mu00b7%y}";
          tooltip-format = "<span>{calendar}</span>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ffbc77'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
          "actions" = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "cpu" = {
          interval = 2;
          format = "{usage}% ";
          min-length = 6;
        };

        "memory" = {
          interval = 3;
          format = "{used} / {total} ";
          tooltip = true;
        };

        "temperature" = {
          thermal-zone = 8;
          critical-threshold = 85;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };

        "hyprland/language" = {
          format-en = "🇺🇸";
          format-hi = "Hi";
          format-mr = "Mr";
          min-length = 5;
          tooltip = false;
        };

        "hyprland/window" = {
          format = " {0}";
          max-length = 50;
          separate-outputs = true;

          rewrite = {
            "(.*)nvim" = " Nvim"; # Neovim
            "(.*)Kitty" = " Kitty"; # Neovim
            "(.*)Zellij" = " Zellij"; # Neovim
            "(.*)Zen Browser" = " Zen"; # Zen Browser (Firefox-based)
            "(.*)Yazi" = " Yazi"; # Yazi file manager
            "(.*)OBS Studio" = "󰻑 OBS"; # OBS
            "(.*)Mission Center" = "󰨇 SysMon";
            "(.*)Discord" = " Discord"; # Optional: Discord
            "(.*)Spotify" = " Spotify"; # Optional: Spotify
          };
        };

        "hyprland/workspaces" = {
          class = "no-margin-padding";
          all-outputs = false;
          active-only = true;
          on-click = "activate";
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          persistent-workspaces = { };
          format = "{icon}";
          format-icons = {
            "1" = "🚀";
            "2" = "💻";
            "3" = "🧪";
            "4" = "📺";
            "5" = "🎼";
            "6" = "📱";
            "7" = "🔐";
            "8" = "💗";
            "9" = "Be bsdk kitne tab kholega 🤬";
            "special" = "🪄";
            "magic" = "🪄";
          };
          persistent-workspaces = { "*" = 3; };
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%  {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-muted = "🔇 0%{format_source}";
          format-source = "🎤 {volume}%";
          format-icons = {
            "headphones" = "🔈";
            "handsfree" = "🎧";
            "headset" = "󰋍";
            "phone" = "📱";
            "portable" = "📴";
            "car" = "📇";
            "default" = [ "🔈" "🔉" "🔊" ];
          };
          on-click = "pavucontrol";
        };

        "network" = {
          interface =
            "wlp0s20f3"; # (Optional) To force the use of this interface
          format-wifi = " ({signalStrength}%) {essid} ";
          format-ethernet = "🖧 {ipaddr}/{cidr}";
          tooltip-format = "󰀂 {ifname} via {gwaddr}";
          format-linked = "󰩠 {ifname} (No IP)";
          format-disconnected = "  Disconnected ";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click =
            "kitty -T nmtui-term -e nmtui"; # -> check hyprland/main.nix for windowrulev2
        };

        "backlight" = {
          device = "nvidia_wmi_ec_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "󰁨" ];
          min-length = 7;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        # Y: need hyde command
        # "custom/keybindhint" = {
        #   format = " ";
        #   tooltip-format = "  Keybinds";
        #   rotate = 0;
        #   on-click = "hyde-shell keybinds_hint";
        # };

        # Y: need hyde command
        # "custom/gpuinfo" = {
        #   exec-if = "hyde-shell gpuinfo --stat amd";
        #   exec = "hyde-shell gpuinfo --use amd ";
        #   return-type = "json";
        #   format = "{0}";
        #   rotate = 0;
        #   interval = 5;
        #   tooltip = true;
        #   max-length = 1000;
        # };

        # "hyprland/workspaces" = {
        #   disable-scroll = false;
        #   show-special = false;
        #   special-visible-only = false;
        #   all-outputs = false;
        # format = "{icon}";
        # format-icons = {
        #   "1" = " ";
        #   "2" = "🚀";
        #   "3" = "📺";
        #   "4" = " ";
        #   "5" = " ";
        #   "magic" = "";
        #   };
        # persistent-workspaces = { "*" = 3; };
        # };
      };
    };
  };
}
