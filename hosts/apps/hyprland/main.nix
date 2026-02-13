{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {

      "$mainMod" = "SUPER";
      "$menu" = "rofi";
      # "$TERMINAL" = "kitty";
      "$TERMINAL" = "ghostty";
      "$FILEMANAGER" = "$terminal -e sh -c 'yazi'";
      "$EDITOR" = "nvim";
      "$VISUAL" = "nvim";
      "$BROWSER" = "zen";
      "$TASKMANAGER" = "missioncenter";

      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      # DX: monitor = name, resolution, position, scale
      monitor = [ ",1920x1200@165,auto,1" ",3840x2160@120,auto,1" ];

      exec-once = [
        "waybar"
        "swww-daemon &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "while true; do ~/.config/swaync/scripts/battery-warning.sh; sleep 60; done &"
      ];

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 2;

        "col.active_border" = "rgba(3d59ffff) rgba(b23dffff) 90deg";
        "col.inactive_border" = "rgba(3c3836aa)";
        # rgba(d65d0eff) rgba(98971aff) 90deg # orignal orange + green
        # rgba(3d59ffff) rgba(b23dffff) 90deg # 🧊 Blue–Purple Contrast (cool & futuristic)
        # rgba(ff3366ff) rgba(ff66ccff) 90deg # ❤️‍🔥 Red–Magenta Energy (bold & vivid)
        # rgba(ff63acff) rgba(c85affff) 90deg # 🌅 Pink–Purple Luxe (soft contrast)
        # rgba(0078ffff) rgba(ff1e00ff) 90deg # 🧬 Electric Blue–Red Clash (high impact)


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
        bezier =
          [ "myBezier, 0.05, 0.9, 0.1, 1.0" "reBezier, 1, 0.99, 0.48,1.12" ];

        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 3, default"
          "border, 1, 6, default"
          "fade, 1, 7, default"
          "workspaces, 1, 4, default"
          "specialWorkspaceIn,1,3,myBezier,slidefadevert"
          "specialWorkspaceOut,1,1.4,reBezier,slidefadevert"

        ];
      };

      input = {
        kb_layout = "us,in";
        repeat_delay = 250; # like above
        repeat_rate = 60; # repeats per second
        force_no_accel = 1;

        # kb_variant = "marathi";
        # kb_options = "ctrl:nocaps";
      };

      gestures = {
        # workspace_swipe = false;
        workspace_swipe_invert = false;
        workspace_swipe_forever = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
        vfr = true; # Y: variable refresh rate.
        # force_default_amdgpu_renderer = false; # Y:NVIDIA compatibility
      };


      windowrule = [
        # Nmtui popup Y: not workign this also
        "float on, match:title ^(IWD-Impala 󱛆 )$"
        "size 28% 65%, match:title ^(IWD-Impala 󱛆 )$"
        "move 65% 3%, match:title ^(IWD-Impala 󱛆 )$"
        "opacity 0.3, match:class SpecialOverlay" # Assuming no regex needed; add ^$ if required

        # Original: windowrule=border_size 0, match:floating 1, match:workspace w[t1]
        # Corrected:
        "border_size 0, match:float true, match:workspace w[t1]" # Or "match:workspace name:w[t1]" if it's a named workspace

        # Original: windowrule=no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:floating 1, match:fullscreen 0, match:pin 0
        # Corrected:
        "no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"

        "float on, match:class (mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60, size 900 170, pin on, no_initial_focus on, match:class (showmethekey-gtk)"
        "border_size 0, no_focus on, match:class (showmethekey-gtk)" # Converted noborder to border_size 0 (common equivalent)
        "suppress_event maximize, match:class .*"
        "opacity 0.0 override, match:class ^(xwaylandvideobridge)$"
        "no_anim on, match:class ^(xwaylandvideobridge)$"
        "no_initial_focus on, match:class ^(xwaylandvideobridge)$"
        "max_size 1 1, match:class ^(xwaylandvideobridge)$"
        "no_blur on, match:class ^(xwaylandvideobridge)$"
        "no_focus on, match:class ^(xwaylandvideobridge)$"
        "fullscreen on, match:class ^(steam_app_[0-9]+)$"


        # "float on, size 28% 65%, move 65% 3%, match:class ^(com.mitchellh.ghostty)$$   , match:title ^(nmtui-term)   $$"
        "float on, size 28% 65%, move 65% 3%, match:title ^(NMTUI-󱛆 )$"

        "float on, match:title ^(floating-ghostty)$"
        "size 60% 35%, match:title ^(floating-ghostty)$"
        "move 20% 5%, match:title ^(floating-ghostty)$"


        # Y: not working anymore
        # "float,class:^(com.mitchellh.ghostty)$,title:^(nmtui-term)$"
        # "size 28% 65%,class:^(com.mitchellh.ghostty)$,title:^(nmtui-term)$"
        # "move 65% 3%,class:^(com.mitchellh.ghostty)$,title:^(nmtui-term)$"
        # "float,title:^(floating-ghostty)$"
        # "size 60% 35%,title:^(floating-ghostty)$"
        # "move 20% 5%,title:^(floating-ghostty)$"
        # "nofullscreenrequest, class:^(steam_app_[0-9]+)$"

        # "workspace 3,class:(obsidian)"
        # "workspace 3,class:(zathura)"
        # "workspace 4,class:(com.obsproject.Studio)"
        # "workspace 5,class:(telegram)"
        # "workspace 5,class:(vesktop)"
        # "workspace 6,class:(teams-for-linux)"
      ];


      workspace = [ "w[tv1], gapsout:0, gapsin:0" "f[1], gapsout:0, gapsin:0" ];
    };
    # extraConfig = ''
    #   source = ~/.config/hypr/swww.conf
    # '';
  };
  imports = [ ./swww.nix ];
}
