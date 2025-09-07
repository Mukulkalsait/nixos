# Y: Costome Session Variables.
{ config, pkgs, ... }: {

  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";
  };

}
