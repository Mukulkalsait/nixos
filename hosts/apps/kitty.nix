{ ... }:

{

  programs.kitty = {
    enable = true;


    # themeFile = "Bright_Lights";
    # themeFile = "Encom";
    # themeFile = "Lavandula";
    # themeFile = "Argonaut";
    themeFile = "TokyoNight";
    # R: use "kitty +kitten themes"

    font = {
      size = 9; # ghostty: font-size = 9
      name = "JetBrainsMono Nerd Font"; # ghostty: font-family (primary)
    };

    settings = {

      # bold_font = "MonaspiceKr Nerd Font"; # ghostty: font-family-bold - this line was missing in your last version, which is why bold text wasn't rendering distinctly
      # italic_font = "MonaspiceRn Nerd Font"; # ghostty: font-family-italic
      # bold_italic_font = "MonaspiceKr Nerd Font"; # ghostty: font-family-bold-italic

      bold_font = "VictorMono Nerd Font";
      italic_font = "VictorMono Nerd Font"; # ghostty: font-family-italic
      bold_italic_font = "VictorMono Nerd Font"; # ghostty: font-family-bold-italic

      font_features = "JetBrainsMono-Regular +liga +dlig";

      # ---- Window / chrome ----
      background_opacity = "0.75"; # ghostty: background-opacity = 0.75
      confirm_os_window_close = "0"; # ghostty: confirm-close-surface = false
      window_padding_width = "0"; # ghostty: window-padding-y/x = 0
      hide_window_decorations = "yes"; # keep the chrome-less look you already run

      # ---- Colors ----
      # theme provides colors 0-15, these override background/foreground/
      # cursor on top of it - same pattern as ghostty's theme + overrides.
      background = "#000000"; # ghostty: background = #000000
      foreground = "#c8d3f5"; # ghostty: foreground = #c8d3f5
      # cursor = "#c8d3f5";

      # ---- Shell startup ----
      # ghostty: command = zsh -ic "fastfetch; exec zsh"
      shell = "zsh -ic \"fastfetch; exec zsh\"";

      # ---- Clipboard ----
      # kitty disables clipboard *read* by default for security. This
      # opts back in to match ghostty's clipboard-read/write = allow.
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      # ---- Cursor ----
      # cursor_shape = "block"; # trail reads cleanest on a block cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.5";
      cursor_underline_thickness = "2.0";

      cursor_blink_interval = "0";
      cursor_stop_blinking_after = "0";

      # ---- Cursor trail ----
      cursor_trail_start_threshold = "0";

      # cursor_trail = "20";
      # cursor_trail_decay = "0.1 0.3";
      # cursor_trail_thickness = "1.2 1.2";

      cursor_trail = "1";
      cursor_trail_decay = "0.01 0.5"; # X and Y decay
      cursor_trail_thickness = "1.2 1.2"; # X and Y thickness

      # Y: faster
      # cursor_trail = "6"; # number of ghost cursors
      # cursor_trail_decay = "0.20 0.08"; # fast fade in X/Y directions
      # cursor_trail_thickness = "1.2 1.2"; # default thickness
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+q" = "no_op"; # unbind close_tab
    };
  };
}
