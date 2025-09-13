# Y: Costome Session Variables.
{ config, pkgs, ... }: {

  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";

    # # Wayland-specific Y: IMPUT METHODS 
    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
    # SDL_IM_MODULE = "fcitx";
    # # Ensure Wayland compatibility
    # GLFW_IM_MODULE = "ibus";
  };

}
