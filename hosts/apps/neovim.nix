# Y:  Neovim with home config.
{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

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
        ]))
      ];
  };

  # Install LSP servers and formatters
  home.packages = with pkgs; [
    # LSP Servers
    lua-language-server
    nil # Nix LSP
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.typescript-language-server
    tailwindcss-language-server
    emmet-ls
    phpactor
    rust-analyzer

    # Formatters & Linters
    stylua
    nodePackages.prettier
    nodePackages.eslint
    nixpkgs-fmt
    rustfmt

    # Additional tools
    tree-sitter
    ripgrep
    fd
    nodejs
    cargo
  ];

  # Optional: Set environment variables
  home.sessionVariables = { EDITOR = "nvim"; };



  # DX: Theis is here to keep the file in home for chaingin configs.
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
