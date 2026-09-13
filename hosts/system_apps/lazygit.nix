# lazygit.nix
# # Y:  Lazygit systemwide
# {
#   programs.lazygit = {
#     enable = true;
#     settings = {
#       gui.showIcons = true;
#       gui.theme = {
#         lightTheme = false;
#         activeBorderColor = [ "green" "bold" ];
#         inactiveBorderColor = [ "grey" ];
#         selectedLineBgColor = [ "blue" ];
#       };
#     };
#   };
# }

# Y:  Lazygit systemwide
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true;
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "green" "bold" ];
        inactiveBorderColor = [ "grey" ];
        selectedLineBgColor = [ "blue" ];
      };

      customCommands = [
        {
          key = "C";
          command = "git commit -m '{{.Form.Type}}{{.Form.Scope}}: {{.Form.Subject}}'";
          context = "files";
          description = "Conventional commit";
          prompts = [
            {
              type = "menu";
              title = "Select type";
              key = "Type";
              options = [
                { name = "feat"; value = "feat"; description = "A new feature for the user"; }
                { name = "fix"; value = "fix"; description = "A bug fix"; }
                { name = "docs"; value = "docs"; description = "Documentation only changes"; }
                { name = "chore"; value = "chore"; description = "Maintenance, dependencies, config"; }
                { name = "refactor"; value = "refactor"; description = "Code change that neither fixes a bug nor adds a feature"; }
                { name = "test"; value = "test"; description = "Adding missing tests or correcting existing tests"; }
                { name = "style"; value = "style"; description = "Changes that do not affect the meaning of the code (white-space, formatting, etc)"; }
              ];
            }
            {
              type = "input";
              title = "Scope (optional)";
              key = "Scope";
            }
            {
              type = "input";
              title = "Description";
              key = "Subject";
            }
          ];
        }
      ];
    };
  };
}
