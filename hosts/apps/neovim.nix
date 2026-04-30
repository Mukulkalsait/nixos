# Y: Neovim with home config.
{ config, pkgs, ... }: {
  programs.neovim = {
    enable = false;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Install TreeSitter grammars via Nix R: WORKS SUPPER BUT PROBLEMATIC....
    # plugins = with pkgs.vimPlugins; [ nvim-treesitter.withAllGrammars ];
  };

  # Install LSP servers and formatters
  home.packages = with pkgs; [


    # B:  APPLICATION FOR NVIM |> 
    ghostscript # For PDF rendering (gs) snack.nvim
    # tectonic # For LaTeX rendering snack.nvim  🈸 Application added.

    # B: Rust Toolchain |> 
    fenix.stable.toolchain # NixOS style Rust Toolchain. 
    cargo-binstall # Faster Binery installation
    cargo-watch # like Tainwind watch
    cargo-edit # cargo add / remove/ tree like commands
    sqlx-cli # sqli cli
    just # makefile
    # rustup # BEST FOR OTHER but not FOR NIX
    # G: for rust linkekrs
    gcc # linker
    glibc.dev # C headers
    pkg-config # build helpers
    openssl # common rust deps
    llvmPackages.libclang # bindgen / clang interface
    # gnumake # B: only needed very few times

    # clang # colverd in llvmPackages.libclang
    # llvm # unnecessary
    # lld # gcc->ld

    pkgs.lldb_22 # provides codelldb for crate.nvim

    # Y: Lang (Programing) |>
    fnm # 🚀 DROP IN REPLACEMENT FOR NodeJs & BUN IMP: BEST for neovim mason and all.
    go # Original go
    perl # perl dont know why do i need this?

    # bun # bun replacement for npm.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.
    uv # PIP replacement. python package /dependency manager.

    # G: LSPs
    biome # Y: Replacement for => Prettier/ESLint for JS/TS/JSON (FORMATER + LINTER)
    lua-language-server # LSP --WORKING
    nixd # NIX lsp --WORKING
    shellcheck # BASH LINTER --WORKING
    vtsls

    emmet-ls # LSP
    tailwindcss-language-server # LSP
    phpactor # LSP 
    # nil # nix-LSP


    # G:  Formatters & Linters
    dockerfile-language-server # NixRepo

    nixpkgs-fmt # FORMATTER -- WORKING
    shfmt # FORMATTER (for Bash/ZSH) --WORKING 

    dockfmt # FORMSTTER -- NOT WORKING 
    stylua # FORMATTER -- NOT WORKING 

    sqls # LSP (for SQL)

    # B: just commented to try if its already on the Mason
    # typescript-language-server # LSP
    # vscode-langservers-extracted # LSP (includes html, css, json)
    # eslint # LINTER
    # stylelint # LINTER (for CSS)
    # bash-language-server # LSP (for Bash/ZSH)
    # mermaid-cli # For Mermaid diagrams (mmdc) snack.nvim
    # sql-formatter # FORMATTER (for SQL)

    # Y:  addsometinfg for terraform
    # yaml-language-server # DX: broken so added with |> bun i -g yaml-language-server 
    # "@shufo/blade-formatter" # Y: FORMATTER (for PHP/Blade; add if packaged, else bun i -g @shufo/blade-formatter)
    # php84Packages.php-codesniffer # LINTER (for PHP)

  ];

  # DX: This is here to keep the file in home for changing configs.
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/mukuldk/1_file/2_git_repos/nvim";

  #================================================================================================================================================
  #  Pull your config directly from GIT into ~/.config/nvim
  #
  # home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  #   owner = "Mukulkalsait";
  #   repo = "nvim";
  #   rev = "main";  
  #   sha256 = "sha256-2V0ZJKEZBZ9Wg3ZMklxwUk3KBiRkJ7paR3QQyXZXlRs=";  # Updated with correct hash
  #   sha256 = "c9709fb51e20cadb46d0b6ca567bb34e19118dd4";  # This will fail but show you the correct hash
  # };
  #================================================================================================================================================
}
