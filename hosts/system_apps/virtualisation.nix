# Y: virtualisation.nix |> Configuration for Podman, Minikube, and Kubernetes tools
{ config, pkgs, ... }: {

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = false;
    enableNvidia = true;
    defaultNetwork.settings.dns_enabled = true;
    # ⏫ fixes DNS resolution in rootless containers.
  };

  # FIX: Set environment variable to point tools to rootless socket
  environment.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };

  # System-wide packages for Kubernetes and container tools
  environment.systemPackages = with pkgs; [
    minikube # kuberneties creater
    kubectl # dont know
    k9s # TUI fro kube
    kubernetes-helm # dont know
    crun # c-liberary for kube
    nvidia-container-toolkit

    podman-compose # podman compose to compose file
    buildah # podman compose lieke another thign
  ];
}

