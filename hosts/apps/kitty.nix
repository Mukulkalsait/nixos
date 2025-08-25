
# kitty.nix

{ lib, config, pkgs, ...}:
{

# Kitty
 programs.kitty = {
  enable = true;
  font = { name = "JetBrainsMono Nerd Font"; size = 9; };
  settings = {
  background_opacity = "0.95";
  confirm_os_window_close = 0;
  };
  keybindings = {
    "ctrl+shift+c" = "copy_to_clipboard";
    "ctrl+shift+v" = "paste_from_clipboard";
  };
};

}
