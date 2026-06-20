# Y: Costome Session Variables.
{ config, pkgs, lib, ... }: {

  home.sessionVariables = {
    TERMINAL = "kitty";
    FILEMANAGER = "yazi";
    EDITOR = "nvim";

    # # Wayland-specific Y: IMPUT METHODS 
    INPUT_METHOD = "fcitx";
    GTK_IM_MODULE = "wayland"; # unset, let Wayland IM handle
    QT_IM_MODULE = "wayland"; # unset, let Wayland IM handle
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus"; # optional, some games/toolkits expect this

    # DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    # PATH = lib.mkForce (lib.makeBinPath [
    #   pkgs.podman
    #   pkgs.podman-compose
    #   pkgs.buildah
    # ]);

    # Y: RUST part----------------------
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";
    # RUST_SRC_PATH = "${pkgs.fenix.stable.rust-src}/lib/rustlib/src/rust/library";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

    # CUDA - These are now confirmed working
    CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
    CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    CUDACXX = "${pkgs.cudaPackages.cudatoolkit}/bin/nvcc";

    LD_LIBRARY_PATH = "/run/opengl-driver/lib:" + "/run/opengl-driver-32/lib:" + "${pkgs.cudaPackages.cudatoolkit}/lib:" + "$LD_LIBRARY_PATH";


    # B: Updated RUST_SRC_PATH: Use rustup's if available, fallback to Nix
    #
    # RUST_SRC_PATH =
    #   if builtins.pathExists "${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library"
    #   then "${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library"
    #   else "${pkgs.rustPlatform.rustLibSrc}/lib/rustlib/src/rust/library"; # Use rustPlatform for Nix fallback
    # B: Isolate rustup to avoid PATH pollution
    #
    # RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    # CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    # PATH = "${config.home.homeDirectory}/.cargo/bin:${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH"; # G: Prioritize rustup

    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
    CC = "${pkgs.gcc}/bin/gcc";

  };


  # Y: Home Paths
  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.cache/.bun/bin"
    "${pkgs.cudaPackages.cudatoolkit}/bin" # For nvcc
  ];

}
