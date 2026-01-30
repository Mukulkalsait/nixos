{
  imports = [

    # G: Folders |>

    # G: Files |>
    # Y: Before Booting.
    ./hardware_and_services.nix
    ./boot_and_Kernal.nix
    ./root_zsh.nix
    ./user.nix
    ./console.nix
    ./greetd.nix

    # Y: While booting
    ./nvidia.nix
    ./containerization.nix

    # Y: After booting.
    ./envVariables.nix
    ./apps_sys.nix
    # ./devEnv.nix
    ./starship
    ./git.nix
    ./lazygit.nix
    ./firewall.nix

    # Y:  Dependencys
    # ./linuwu-sense.nix # latest kernal puller.
    # ./linuwu-sense_kernal_fixed.nix # fixed the kernal version to the working.
    ./mchose_ace_68.nix

  ];
}

