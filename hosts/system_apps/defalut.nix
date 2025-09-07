{
  imports = [

    # G: Folders |>

    # G: Files |>
    # Y: Before Booting.
    ./hardware_and_services.nix
    ./boot.nix
    ./user.nix
    ./console.nix
    ./greetd.nix

    # Y: While booting
    ./nvidia.nix
    ./virtualisation.nix

    # Y: After booting.
    ./apps_sys.nix
    ./git.nix
    ./fzf.nix
    ./lazygit.nix

    # Y:  Dependencys
    ./linuwu-sense.nix
    ./mchose_ace_68.nix

  ];
}

