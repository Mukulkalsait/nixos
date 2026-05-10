

## Safe-ish Updates

```bash id="syf1u2"
nix flake lock --update-input home-manager
```

Usually safe.

---

```bash id="t0yq6j"
nix flake lock --update-input fenix
```

Rust toolchains only.

---

```bash id="6d9l0o"
nix flake lock --update-input wifitui
```

Tiny app.

---

```bash id="e5n3lq"
nix flake lock --update-input ghostty
```

Terminal only.

---

```bash id="wopw7r"
nix flake lock --update-input zen-browser
```

Usually safe.

---

```bash id="fmyu2g"
nix flake lock --update-input nixpkgs-terraform
```

Terraform overlay.

---

```bash id="xx0l9v"
nix flake lock --update-input nur
```

Usually okay.

---

# CAUTION INPUTS

These can break graphical stack/session compatibility.

---

## Hyprland

```bash id="e6ok6v"
nix flake lock --update-input hyprland
```

Potential issues:

* wlroots mismatch
* plugin mismatch
* portal mismatch

Still usually recoverable.

---

## Hyprland Plugins

```bash id="nv4r4q"
nix flake lock --update-input hyprland-plugins
```

Can break instantly if Hyprland API changed.

Usually update BOTH together:

```bash id="4dbtja"
nix flake lock --update-input hyprland
nix flake lock --update-input hyprland-plugins
```

---

# HIGH RISK INPUT

## nixpkgs

```bash id="vzsz5m"
nix flake lock --update-input nixpkgs
```

THIS is:

* kernel
* NVIDIA
* mesa
* systemd
* glibc
* gcc
* drivers
* entire OS

This is what broke your system.

---

# VERY IMPORTANT DETAIL

Because you use:

```nix
inputs.nixpkgs.follows = "nixpkgs";
```

Updating:

* home-manager
* fenix
* zen-browser

does NOT necessarily update their internal nixpkgs.

They stay aligned to your pinned nixpkgs.

This is GOOD.

---

# Your Best Workflow

## Daily / frequent updates

Safe:

```bash id="8f7lqz"
nix flake lock --update-input home-manager
nix flake lock --update-input fenix
nix flake lock --update-input ghostty
nix flake lock --update-input zen-browser
```

Then:

```bash id="i5ivqk"
snrsf
```

---

# For Hyprland

Update separately and cautiously:

```bash id="eah1zc"
nix flake lock --update-input hyprland
nix flake lock --update-input hyprland-plugins
```

Then:

```bash id="09nkrl"
sudo nixos-rebuild build --flake .
```

NOT switch first.

---

# For nixpkgs

Treat like a distro upgrade.

Do:

```bash id="2k0m0g"
git add .
git commit -m "working state before nixpkgs update"
```

Then:

```bash id="jk6v3v"
nix flake lock --update-input nixpkgs
```

Then TEST:

```bash id="cl0i38"
sudo nixos-rebuild build --flake .
```

If successful:

```bash id="d7o6ai"
sudo nixos-rebuild switch --flake .
```

If broken:

```bash id="8n79xh"
git checkout flake.lock
```

Instant rollback.

---

# EXTREMELY IMPORTANT RECOMMENDATION

You should seriously consider this:

```nix
inputs = {
  nixpkgs.url =
    "github:NixOS/nixpkgs/nixos-unstable-small";
};
```

OR better:

```nix
github:NixOS/nixpkgs/<specific-working-commit>
```

for NVIDIA laptops.

Because unstable moves FAST.

---

# Your Current Elite Recovery Strategy

You already discovered one of the most important NixOS skills:

> NEVER fear updates if flake.lock is committed.

That is the entire power of flakes 😄
