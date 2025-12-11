# Y: Costome Session Variables.
{ lib, config, pkgs, yazi, ... }:
{ config, pkgs, lib, ... }: {

  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";

    # # Wayland-specific Y: IMPUT METHODS 
    INPUT_METHOD = "fcitx";
    GTK_IM_MODULE = "wayland"; # unset, let Wayland IM handle
    QT_IM_MODULE = "wayland"; # unset, let Wayland IM handle
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus"; # optional, some games/toolkits expect this

    # DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    # PATH = lib.mkForce (lib.makeBinPath [
    #   pkgs.podman
    #   pkgs.podman-compose
    #   pkgs.buildah
    # ]);
  };

  # Y: Home Paths
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.cache/.bun/bin"
  ];




}
