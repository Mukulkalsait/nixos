# Y: containerization.nix |> Configuration for Podman, Minikube, and Kubernetes tools
{ config, pkgs, ... }: {

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
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
    gomanagedocker # go manage doker/podman
    podman-tui # TUI Tool for Podman Specific.
    ctop # Top utility for Containerisation.
    podman-compose # podman compose to compose file.
    buildah # podman compose lieke another thign.

    kind # Kubernetes IN Docker.
    kubectl # dont know.
    k9s # TUI fro kube.
    kubernetes-helm # helm
    crun # c-liberary for kube.

    # B: Cloud |>
    awscli2
  ];
}

