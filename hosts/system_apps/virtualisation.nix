# Y: Vitrualisation = Docker | Podman | Kuberneties and other.
{ config, pkgs, ... }: {

  virtualisation.docker = {
    enable = true; # service enabled
    enableOnBoot = false; # systemctl service stoped
  };

  users.users.mukuldk.extraGroups = [ "docker" ]; # group add to user.

  # Y: (Optional) Podman alongside Docker will start podman soon.
  # DX:
  # virtualisation.podman.enable = true;
  # virtualisation.podman.enableOnBoot = false;
  # virtualisation.podman.dockerCompat = true;

}

