# Y: virtualisation.nix |> Configuration for Podman, Minikube, and Kubernetes tools
{ config, pkgs, ... }: {

  # DX: Initial Docker config.
  # virtualisation.docker = {
  #   enable = true; # service enabled
  #   enableOnBoot = false; # systemctl service stoped
  # };
  # users.users.mukuldk.extraGroups = [ "docker" ]; # group add to user.

  virtualisation.podman = {
    enable = true; # Enables Podman service
    dockerCompat = true; # Symlinks /usr/bin/docker to podman for CLI aliasing
    dockerSocket.enable = true; # Enables Podman socket at /var/run/docker.sock for lazydocker
    enableNvidia = true; # Enables NVIDIA GPU support for containers (RTX 4050)
  };

  # NOTE: Uncomment if rootful Podman is needed (optional)
  # users.users.mukuldk.extraGroups = [ "podman" ];

  # System-wide packages for Kubernetes and container tools
  environment.systemPackages = with pkgs; [
    minikube # CLI for local Kubernetes clusters
    kubectl # Kubernetes CLI
    k9s # TUI for Kubernetes management
    kubernetes-helm # Helm for Kubernetes package management
    podman-compose # Compose for multi-container apps
    buildah # Tool for building OCI images
  ];

  # TAG: NVIDIA driver setup should be in configuration.nix if not already.
}
