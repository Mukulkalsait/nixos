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
    # B: Updated RUST_SRC_PATH: Use rustup's if available, fallback to Nix
    RUST_SRC_PATH =
      if builtins.pathExists "${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library"
      then "${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library"
      else "${pkgs.rustPlatform.rustLibSrc}/lib/rustlib/src/rust/library"; # Use rustPlatform for Nix fallback
    # B: Isolate rustup to avoid PATH pollution
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    PATH = "${config.home.homeDirectory}/.cargo/bin:${config.home.homeDirectory}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH"; # G: Prioritize rustup

    # Y: -------------------------------
    # in case of conflicts 
    # cretate "rust-toolchain.toml" in project root
    # ----
    #  add thsi 
    # ----
    #  [toolchain]
    #     channel = "stable"
    #     components = ["rust-src", "clippy", "rustfmt"]
    #
  };

  home.activation = {
    initRustup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d $HOME/.rustup ]; then
        ${pkgs.rustup}/bin/rustup toolchain install stable
        ${pkgs.rustup}/bin/rustup component add rust-src clippy rustfmt
      fi
    '';
  };

  # Y: Home Paths
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.cache/.bun/bin"
  ];

}
