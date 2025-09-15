# Y: Costome Session Variables.
{ config, pkgs, ... }: {

  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";

    # # Wayland-specific Y: IMPUT METHODS 
    INPUT_METHOD = "fcitx";
    GTK_IM_MODULE = ""; # unset, let Wayland IM handle
    QT_IM_MODULE = ""; # unset, let Wayland IM handle
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus"; # optional, some games/toolkits expect this
  };

}
