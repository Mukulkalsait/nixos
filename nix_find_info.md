### Learn the `nix eval` command

This is a **very useful** command for checking what Nixpkgs actually provides without building anything.

#### Basic Usage

```bash
nix eval nixpkgs#some.package.attribute
```

#### Most Useful Examples for you:

| Command | What it does |
|---------|--------------|
| `nix eval --raw nixpkgs#linuxPackages_latest.nvidiaPackages.beta.version` | Shows the **version** of the beta driver |
| `nix eval --raw nixpkgs#linuxPackages_latest.nvidiaPackages.stable.version` | Shows stable driver version |
| `nix eval nixpkgs#hello` | Shows the full derivation of `hello` package |
| `nix eval nixpkgs#vim.name` | Shows the name of the vim package |
| `nix eval --raw nixpkgs#firefox.version` | Shows Firefox version cleanly |
| `nix eval nixpkgs#stdenv.hostPlatform.system` | Shows your system (x86_64-linux) |

**Tips:**
- Use `--raw` when you just want the clean output (like version numbers).
- You can explore any package: `nix eval nixpkgs#pkgsCross.mingwW64.go.version`
- To see all attributes of something: `nix eval nixpkgs#nvidiaPackages.beta --json`

#### Quick way to check NVIDIA drivers anytime:

```bash
nix eval --raw nixpkgs#linuxPackages_latest.nvidiaPackages.stable.version
nix eval --raw nixpkgs#linuxPackages_latest.nvidiaPackages.beta.version
nix eval --raw nixpkgs#linuxPackages_latest.nvidiaPackages.production.version
```

This is exactly how you discovered that `beta` had 595 while others were still on 580.

---

Would you like me to also give you a small **alias** you can add to your shell so you can quickly check NVIDIA driver versions with one command?

Also, after you switch to beta and reboot, let me know what `nvidia-smi` shows. If everything goes well, we can clean up a few more things in your NVIDIA + Hyprland setup.

```bash  
nix profile list # list added profile into config
export LIBCLANG_PATH=$(nix eval -raw nixpkgs#llvmPackages.libclang)/lib # use lnix pkgs path.
sudo nix-channel list
sudo nix-channel --help
sudo nix-search-tv --help
```

