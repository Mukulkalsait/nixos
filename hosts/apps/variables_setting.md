
# Step 1 — find libclang location

Run:

```bash
nix eval --raw nixpkgs#llvmPackages.libclang.lib
```

or easier:

```bash
fd libclang.so /nix/store
```

You will see something like:

```
/nix/store/xxxx-libclang-18/lib/libclang.so
```

---

# Step 2 — export LIBCLANG_PATH

Temporarily test:

```bash
export LIBCLANG_PATH=$(nix eval --raw nixpkgs#llvmPackages.libclang.lib)/lib
```

Then run again:

```
cargo install tree-sitter-cli
```

It should compile successfully.

---

# Step 3 — permanent fix (Home-Manager)

Add this to your **home.nix**:

```nix
home.sessionVariables = {
  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
};
```

Then rebuild:

```
snrsf
```

Now the variable will always exist.

Verify:

```
echo $LIBCLANG_PATH
```

You should see something like:

```
/nix/store/xxxx-libclang/lib
```

---

# Why this happens on Nix (important concept)

Unlike Ubuntu or Arch:

```
/usr/lib/libclang.so
```

does not exist.

Instead Nix stores libraries like:

```
/nix/store/abcd1234-libclang/lib/libclang.so
```

Cargo does not search that location automatically.

So we explicitly tell it via:

```
LIBCLANG_PATH
```

---

# Your final Rust environment should now be

```nix
home.packages = with pkgs; [

  rustup
  gcc
  pkg-config
  openssl
  llvmPackages.libclang
];
```

and

```nix
home.sessionVariables = {
  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
};
```

---

# After that install tree-sitter

```
cargo install tree-sitter-cli
```

Then check:

```
tree-sitter --version
```

---

# One important note

For **Neovim** you **do NOT actually need tree-sitter CLI**.
Plugins like **nvim-treesitter** compile grammars automatically.

But installing it is still useful if you:

* develop grammars
* debug parsers
* run `tree-sitter parse`

---

✅ Once this works, your **Nix + Rust + Neovim environment will be fully stable**.

---

If you want, I can also show you a **much cleaner Nix trick used by Rust developers that eliminates this `LIBCLANG_PATH` problem entirely** (it uses `lib.makeLibraryPath`).

You **do have `libclang` installed**, but **Cargo cannot find it** because Nix does not expose library paths globally.

So the problem is **not installation** — it is **environment variables**.

---

# The exact error

```
Unable to find libclang
set the LIBCLANG_PATH environment variable
```

The Rust crate **bindgen** (used by **tree-sitter**) needs:

```
libclang.so
```

But it doesn't know where Nix placed it.

---

# Step 1 — find libclang location

Run:

```bash
nix eval --raw nixpkgs#llvmPackages.libclang.lib
```

or easier:

```bash
fd libclang.so /nix/store
```

You will see something like:

```
/nix/store/xxxx-libclang-18/lib/libclang.so
```

---

# Step 2 — export LIBCLANG_PATH

Temporarily test:

```bash
export LIBCLANG_PATH=$(nix eval --raw nixpkgs#llvmPackages.libclang.lib)/lib
```

Then run again:

```
cargo install tree-sitter-cli
```

It should compile successfully.

---

# Step 3 — permanent fix (Home-Manager)

Add this to your **home.nix**:

```nix
home.sessionVariables = {
  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
};
```

Then rebuild:

```
snrsf
```

Now the variable will always exist.

Verify:

```
echo $LIBCLANG_PATH
```

You should see something like:

```
/nix/store/xxxx-libclang/lib
```

---

# Why this happens on Nix (important concept)

Unlike Ubuntu or Arch:

```
/usr/lib/libclang.so
```

does not exist.

Instead Nix stores libraries like:

```
/nix/store/abcd1234-libclang/lib/libclang.so
```

Cargo does not search that location automatically.

So we explicitly tell it via:

```
LIBCLANG_PATH
```

---

# Your final Rust environment should now be

```nix
home.packages = with pkgs; [

  rustup
  gcc
  pkg-config
  openssl
  llvmPackages.libclang
];
```

and

```nix
home.sessionVariables = {
  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
};
```

---

# After that install tree-sitter

```
cargo install tree-sitter-cli
```

Then check:

```
tree-sitter --version
```

---

# One important note

For **Neovim** you **do NOT actually need tree-sitter CLI**.
Plugins like **nvim-treesitter** compile grammars automatically.

But installing it is still useful if you:

* develop grammars
* debug parsers
* run `tree-sitter parse`

---

✅ Once this works, your **Nix + Rust + Neovim environment will be fully stable**.

---

If you want, I can also show you a **much cleaner Nix trick used by Rust developers that eliminates this `LIBCLANG_PATH` problem entirely** (it uses `lib.makeLibraryPath`).

