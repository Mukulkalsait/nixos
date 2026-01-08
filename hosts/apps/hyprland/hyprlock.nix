let
  # ===== COLOR SCHEMES =====
  # Uncomment ONE scheme at a time

  # Gruvbox
  # colors = {
  # fg = "rgba(235, 219, 178, 1.0)";
  # bgDim = "rgba(40, 40, 40, 0.4)";
  # accent = "rgba(204, 136, 34, 1.0)";
  # date = "rgba(242, 243, 244, 0.75)";
  # accent2 = "rgba(136, 192, 208, 1.0)";
  # accent3 = "rgba(204, 136, 34, 1.0)";
  # uname = "rgb(149 198 104 / 100%)";
  # battery = "rgb(255 229 104 / 100%)";
  # };

  # Catppuccin Mocha
  colors = {
    fg = "rgba(205, 214, 244, 1.0)";
    bgDim = "rgba(30, 30, 46, 0.4)";
    accent = "rgba(243, 139, 168, 1.0)";

    date = "rgba(242, 243, 244, 0.75)";
    accent2 = "rgba(136, 192, 208, 1.0)";
    accent3 = "rgba(204, 136, 34, 1.0)";
    uname = "rgb(149 198 104 / 100%)";
    battery = "rgb(255 229 104 / 100%)";
  };

  # Nord
  # colors = {
  # fg = "rgba(216, 222, 233, 1.0)";
  # bgDim = "rgba(46, 52, 64, 0.4)";
  # accent = "rgba(136, 192, 208, 1.0)";
  # date = "rgba(242, 243, 244, 0.75)";
  # accent2 = "rgba(136, 192, 208, 1.0)";
  # accent3 = "rgba(204, 136, 34, 1.0)";
  # uname = "rgb(149 198 104 / 100%)";
  # battery = "rgb(255 229 104 / 100%)";
  # };
in
{
  programs.hyprlock = {
    enable = true;

    settings = {

      # =====================
      # GENERAL
      # =====================
      general = {
        no_fade_in = true;
        no_fade_out = true;
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
      };

      # =====================
      # BACKGROUND
      # =====================
      background = [{
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;

        # blur_passes = 2;
        # blur_size = 8;
        contrast = 1.0;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      }];

      # =====================
      # INPUT FIELD
      # =====================
      input-field = [{
        monitor = "";
        size = "250, 60";
        position = "0, -200";

        dots_center = true;
        dots_size = 0.25;
        dots_spacing = 0.35;

        outline_thickness = 2;
        rounding = -1;

        inner_color = colors.bgDim;
        outer_color = "rgba(0, 0, 0, 0)";
        font_color = colors.fg;
        check_color = colors.accent;

        placeholder_text = "PassWD";
        hide_input = false;

        halign = "center";
        valign = "center";
        shadow_passes = 1;
      }];

      # =====================
      # LABELS
      # =====================
      label = [

        # ---- DATE ----
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          font_size = 22;
          font_family = "JetBrains Mono";
          color = colors.date;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # ---- TIME ----
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          color = colors.fg;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }

        # ---- CURRENT SONG ----
        {
          monitor = "";
          path = "~/.config/hypr/scripts/runnins_song.sh";
          text = ''cmd[update:1000] echo "$(/home/you/Documents/Scripts/whatsong.sh)"'';
          font_size = 18;
          font_family = "Metropolis Light, Font Awesome 6 Free Solid";
          color = colors.accent2;
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }

        # ---- USER ----
        {
          monitor = "";
          # or use $USER directly
          text = "$USER";
          font_size = 14;
          font_family = "JetBrains Mono";
          color = colors.uname;
          position = "0, -10";
          halign = "center";
          valign = "top";
        }

        # ---- BATTERY ----
        {
          monitor = "";
          # REQUIRED SCRIPT:
          path = "~/.config/hypr/scripts/battery.sh";
          text = ''cmd[update:1000] echo "$(/home/you/Documents/Scripts/battery.sh)"'';
          font_size = 24;
          font_family = "JetBrains Mono";
          color = colors.battery;
          position = "-90, -10";
          halign = "right";
          valign = "top";
        }

        # ---- NETWORK ----
        {
          monitor = "";
          # REQUIRED SCRIPT:
          path = "~/.config/hypr/scripts/wifi.sh";
          text = ''cmd[update:1000] echo "$(/home/you/Documents/Scripts/network-status.sh)"'';
          font_size = 24;
          font_family = "JetBrains Mono";
          color = colors.accent2;
          position = "-20, -10";
          halign = "right";
          valign = "top";
        }
      ];

      # =====================
      # IMAGES
      # =====================
      image = [

        # ---- PROFILE PICTURE ----
        {
          monitor = "";
          # REQUIRED:
          path = "~/.config/hypr/media/profileImg.jpg";
          size = 200;
          border_size = 2;
          border_color = colors.fg;
          position = "0, -100";
          halign = "center";
          valign = "center";
        }

        # ---- DE / LOGO ----
        {
          monitor = "";
          # REQUIRED:
          # path = "./media/yangKai-square-small-dp.jpg";
          size = 75;
          border_size = 2;
          border_color = colors.fg;
          position = "-50, 50";
          halign = "right";
          valign = "bottom";
        }
      ];
    };
  };
}


