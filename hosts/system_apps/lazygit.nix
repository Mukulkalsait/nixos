# Y:  Lazygit systemwide
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true;
      gui.border = "rounded";
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "#78A9FF" "bold" ];
        inactiveBorderColor = [ "#525252" ];
        optionsTextColor = [ "#bebebe" ];
        selectedLineBgColor = [ "#2a2a2a" "bold" ];
        selectedRangeBgColor = [ "#2a2a2a" ];
        cherryPickedCommitBgColor = [ "#2a2a2a" ];
        cherryPickedCommitFgColor = [ "#78A9FF" ];
        unstagedChangesColor = [ "#ff7eb6" ];
        stagedChangesColor = [ "#42be65" ];
      };

    };
  };
}

