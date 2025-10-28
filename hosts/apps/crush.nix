{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nur.repos.charmbracelet.modules.crush
  ];

  programs.crush = {
    enable = true;
    settings = { };
  };
}

