{ config, pkgs, inputs, ... }:

{
  # Import ONLY the Crush module, not all NUR modules
  imports = [
    "${inputs.nur}/repos/charmbracelet/modules/crush"
  ];

  programs.crush = {
    enable = true;
    settings = { };
  };
}

