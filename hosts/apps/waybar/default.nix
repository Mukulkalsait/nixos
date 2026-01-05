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
        modules-left = [ "hyprland/workspaces" "tray" "cpu" "memory" "clock" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "network" "pulseaudio" "temperature" "backlight" "battery" ];

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };

        "clock" = {
          format = "{:%I:%M %p}";
          rotate = 0;
          format-alt = "{:%H:%M  %d-%m-%Y}";
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
          format = "{usage}%  |";
          min-length = 6;
        };

        "memory" = {
          interval = 3;
          format = " {used} / {total} ";
          tooltip = true;
        };


        "hyprland/language" = {
          format-en = "🇺🇸";
          format-hi = "Hi";
          format-mr = "Mr";
          min-length = 5;
          tooltip = false;
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
            "1" = "💻";
            "2" = "🌈";
            "3" = "🎬";
            "4" = "🕹️";
            "5" = "🛞";
            "6" = "📱";
            "7" = "🔐";
            "8" = "📟";
            "9" = "💗";
            "10" = "🎮Be🎼bsdk💻kitne🖥️spaces📺kholega🤬";
            "special" = "🪄";
          };
          persistent-workspaces = { "*" = 3; };
        };

        "hyprland/window" = {
          format = "{0}";
          max-length = 50;
          separate-outputs = true;

          rewrite = {
            "(.*)nvim*" = " Nvim"; # Neovim
            "(.*)Kitty*" = " Kitty"; # Neovim
            "(.*)WhatsApp Business - Zen Twilight" = "  Whatsapp"; # Zen Browser (Firefox-based)
            "(.*)Yazi*" = " Yazi:*"; # Yazi file manager
            "(.*)OBS Studio" = "󰻑 OBS"; # OBS
            "(.*)Mission Center" = "󰨇 SysMon";
          };
        };


        "pulseaudio" = {
          format = "{icon} {volume} {format_source}";
          format-bluetooth = "🎧 {volume} {format_source}";
          format-muted = "🔇 {format_source}";
          format-source = "🎤 {volume}";
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
          # interface = "wlp0s20f3"; # (Optional) To force the use of this interface
          format-wifi = "|{essid}|{signalStrength}";
          format-ethernet = "🖧 {ipaddr}/{cidr}";
          format-linked = "󰩠 {ifname} (No-IP)";
          format-disconnected = "  Disconnected";
          # Y: |  󱛁 󱚾 󱛇 󰸋  󰤟 󰤥 󰤨 󰤪 |
          tooltip-format = "{ifname}\nIP: {ipaddr}/{cidr}\nGW: {gwaddr}\nSignal: {signalStrength}%";
          on-click = "ghostty --title='NMTUI-󱛆 ' -e nmtui"; # Y: -> check hyprland/main.nix for windowrulev2
        };


        "temperature" = {
          thermal-zone = 8;
          critical-threshold = 85;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
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
          format = "{icon} {capacity}";
          format-charging = "⚡ {capacity}";
          format-alt = "{icon} {time}";
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
