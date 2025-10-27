# Y: Neovim with home config.
{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Install TreeSitter grammars via Nix
    plugins = with pkgs.vimPlugins;
      [
        # TreeSitter with all grammars
        (nvim-treesitter.withPlugins (p: [
          p.html
          p.css
          p.javascript
          p.typescript
          p.tsx
          p.php
          p.json
          p.yaml
          p.markdown
          p.markdown_inline
          p.sql
          p.lua
          p.vim
          p.vimdoc
          p.rust
          p.nix
          p.bash
          p.kdl
          # Added for snacks.nvim => all are TreeSitter Parser.
          p.latex # Markdown with diagrams or LaTeX Math sxpression 
          p.svelte
          p.vue
          p.typst
        ]))
      ];
  };

  # Install LSP servers and formatters
  home.packages = with pkgs; [
    glow # TUI for markdown files 
    nil # nix-LSP
    nixpkgs-fmt # FORMATTER

    lua-language-server # LSP
    rustfmt # FORMATTER
    rust-analyzer # LSP

    stylua # FORMATTER
    emmet-ls # LSP
    tailwindcss-language-server # LSP
    phpactor # LSP
    biome # Y: Replacement for => Prettier/ESLint for JS/TS/JSON (FORMATER + LINTER)
    shellcheck # BASH LINTER

    ghostscript # For PDF rendering (gs) snack.nvim
    tectonic # For LaTeX rendering snack.nvim

    # Formatters & Linters
    dockerfile-language-server # NixRepo
    dockfmt

    nodePackages.typescript-language-server # LSP
    nodePackages.vscode-langservers-extracted # LSP (includes html, css, json)
    nodePackages.eslint # LINTER
    nodePackages.stylelint # LINTER (for CSS)
    nodePackages.bash-language-server # LSP (for Bash/ZSH)
    nodePackages.mermaid-cli # For Mermaid diagrams (mmdc) snack.nvim
    nodePackages.sql-formatter # FORMATTER (for SQL)

    # nodePackages.yaml-language-server # DX: broken so added with |> bun i -g yaml-language-server 
    # nodePackages."@shufo/blade-formatter" # Y: FORMATTER (for PHP/Blade; add if packaged, else bun i -g @shufo/blade-formatter)

    phpPackages.php-codesniffer # LINTER (for PHP)
    shfmt # FORMATTER (for Bash/ZSH)
    sqls # LSP (for SQL)

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
