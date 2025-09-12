{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1200@165,auto,1";
      "$mainMod" = "SUPER";
      "$menu" = "rofi";
      "$TERMINAL" = "kitty";
      "$FILEMANAGER" = "$terminal -e sh -c 'yazi'";
      "$EDITOR" = "nvim";
      "$VISUAL" = "nvim";
      "$BROWSER" = "zen";
      "$TASKMANAGER" = "missioncenter";

      exec-once = [
        "waybar"
        "swww-daemon &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "bat80"
        "rgbset"
      ];

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 2;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 90deg";
        "col.inactive_border" = "rgba(3c3836aa)";

        # "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        # "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "dwindle"; # master, dwindle
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = false;
        mfact = 0.5;
      };

      decoration = {
        rounding = 3;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = { enabled = false; };
        blur = { enabled = false; };
      };

      animations = {
        enabled = true;
        # Smooth, fast animations
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.0" ];

        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 3, default"
          "border, 1, 6, default"
          "fade, 1, 7, default"
          "workspaces, 1, 4, default"
        ];
      };

      input = {
        kb_layout = "us,in";
        # kb_variant = "marathi";
        repeat_delay = 280; # like above
        repeat_rate = 50; # repeats per second
      };

      gestures = {
        workspace_swipe = false;
        workspace_swipe_invert = false;
        workspace_swipe_forever = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
      };

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        # Nmtui popup
        "float,title:^(nmtui-term)$"
        "size 22% 60%,title:^(nmtui-term)$"
        "move 75% 5%,title:^(nmtui-term)$"

        # "workspace 3,class:(obsidian)"
        # "workspace 3,class:(zathura)"
        # "workspace 4,class:(com.obsproject.Studio)"
        # "workspace 5,class:(telegram)"
        # "workspace 5,class:(vesktop)"
        # "workspace 6,class:(teams-for-linux)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      workspace = [ "w[tv1], gapsout:0, gapsin:0" "f[1], gapsout:0, gapsin:0" ];
    };
    # extraConfig = ''
    #   source = ~/.config/hypr/swww.conf
    # '';
  };
  imports = [ ./swww.nix ];
}
