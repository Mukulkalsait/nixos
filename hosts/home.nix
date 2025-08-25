{ config, pkgs, inputs, ... }:
{
# inputs.home-manager.nixosModules.default

 imports =
   [ # apps
     ./apps
     inputs.zen-browser.homeModules.twilight
   ];

 home.username = "mukuldk";
 home.homeDirectory = "/home/mukuldk";
 home.stateVersion = "25.05";

 programs.home-manager.enable = true;
 programs.zen-browser = {enable = true;};


 # enable XDG Support:
 xdg.enable = true;

 xdg.desktopEntries.kitty = {
 name = "Kitty";
 genericName = "Terminal";
 exec = "${pkgs.kitty}/bin/kitty";
 icon = "kitty";
 type = "Application";
 categories = ["System" "TerminalEmulator"];
 };

 # default apps: 
 xdg.mimeApps.defaultApplications = {
     "x-scheme-handler/terminal"= ["kitty.desktop"];
     "text/plain" = ["nvim.desktop"];
 };

  home.sessionVariables ={
     TERMINAL = "kitty";
     FILEMANAGER = "yazi";
     EDITOR = "nvim";
 };
}
