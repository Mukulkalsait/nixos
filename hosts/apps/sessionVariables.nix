{ config, pkgs, ... }: {
  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
