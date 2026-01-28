# Y: containerization.nix |> Configuration for Podman, Minikube, and Kubernetes tools
{ config, pkgs, ... }: {

  virtualisation.lxd.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = false; # true will alias docker utility route to podman.
    dockerSocket.enable = false; # avoide conflicts
    defaultNetwork.settings.dns_enabled = true; # dns fix rootless
    # ⏫ fixes DNS resolution in rootless containers.
  };
  hardware.nvidia-container-toolkit = { enable = true; };

  # FIX: Set environment variable to point tools to rootless socket
  environment.sessionVariables = {
    PODMAN_PRIVATE_UNIX_SOCKET = "/run/user/%U/podman/podman.sock"; # %U = user ID; better than hardcoded 1000
    DOCKER_HOST = "unix:///run/user/%U/podman/podman.sock"; # Keep for compat, but PODMAN_* prioritizes for tui
  };

  # System-wide packages for Kubernetes and container tools
  environment.systemPackages = with pkgs; [
    # minikube # kuberneties creater
    # nvidia-container-toolkit # For NVIDIA support
    # nvidia-podman-kit # Additional NVIDIA support for Podman Y: not found 

    # lazydocker # TUI lazy Docker.
    dive # TUI Docker Images Layers.
    gomanagedocker # go manage doker/podman
    podman-tui # TUI Tool for Podman Specific.
    podman-compose # podman compose to compose file.
    ctop # Top utility for Containerisation.
    buildah # podman compose lieke another thign.

    kind # Kubernetes IN Docker.
    kubectl # dont know.
    # kdash # TUI kuberneties dashboard.Y: unstable deu to NixUpdates = will be stable soon so uncommit it whenn you see it.
    k9s # TUI fro kube.
    kubernetes-helm # helm
    crun # c-liberary for kube.
    # terraform-versions."1.9.8" # Terraform with version 

    # B: Cloud |>
    awscli2
  ];
}

