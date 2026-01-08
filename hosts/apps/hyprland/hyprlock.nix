{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        # no_fade_in = false;
        # grace = 10;
        hide_cursor = true;
        #------------------
        no_fade_in = true;
        no_fade_out = true;
        grace = 0;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        # font_family = "JetBrains Mono ";
        font_family = "JetBrains Mono Extrabold";
        # color = "rgba(235, 219, 178, 1.0)";
        position = "0, 300";
        # position = 0, 200
        halign = "center";
        walign = "center";

        shadow_passes = 1;
        #------------------------------
        # monitor = 
        # text = cmd[update:1000] echo "$(date +"%-I:%M")"
        color = "rgba(242, 243, 244, 0.75)";
      };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        # font_color = "rgb(235, 219, 178)";
        # inner_color = "rgb(40, 40, 40)";
        # outer_color = "rgb(60, 56, 54)";
        outline_thickness = 5;
        # placeholder_text = "$USER";
        shadow_passes = 1;
        # -------------------------------
        #
        # position = 0, -200
        # monitor = size = 250, 60
        # outline_thickness = 2
        # dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35;
        # Scale of dots' absolute size, 0.0 - 1.0
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = "$foreground";
        fade_on_empty = false;
        # rounding = -1
        check_color = "rgb(204, 136, 34)";
        placeholder_text = "<i><span foreground='#cdd6f4'>Input Password...</span></i>";
        hide_input = false;
        halign = "center";
        valign = "center";
      }];
    };
  };
}
