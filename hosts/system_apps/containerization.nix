# Y: virtualisation.nix |> Configuration for Podman, Minikube, and Kubernetes tools
{ config, pkgs, ... }: {

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = false;
    defaultNetwork.settings.dns_enabled = true;
    # ⏫ fixes DNS resolution in rootless containers.
  };
  hardware.nvidia-container-toolkit = { enable = true; };

  # FIX: Set environment variable to point tools to rootless socket
  environment.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };

  # System-wide packages for Kubernetes and container tools
  environment.systemPackages = with pkgs; [
    # minikube # kuberneties creater
    # nvidia-container-toolkit # For NVIDIA support
    # nvidia-podman-kit # Additional NVIDIA support for Podman Y: not found 

    podman-tui # TUI for PODMAN
    # lazydocker # TUI lazy Docker.
    podman-tui # TUI Tool for Podman Specific.
    ctop # Top utility for Containerisation.
    podman-compose # podman compose to compose file.
    buildah # podman compose lieke another thign.

    kind # Kubernetes IN Docker.
    kubectl # dont know.
    k9s # TUI fro kube.
    kubernetes-helm # dont know.
    crun # c-liberary for kube.

    # B: Cloud |>
    awscli2
  ];
}

