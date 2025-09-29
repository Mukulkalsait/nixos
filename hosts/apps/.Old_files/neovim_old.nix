# Y:  Neovim with home config.
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
        ]))
      ];
  };

  # Install LSP servers and formatters
  home.packages = with pkgs; [
    nil # LSP
    nixpkgs-fmt # FORMATER

    lua-language-server # LSP
    rustfmt # FORMATER
    rust-analyzer # LSP

    stylua # FORMATER
    emmet-ls # LSP
    tailwindcss-language-server # LSP
    phpactor # LSP

    # Formatters & Linters
    nodePackages.typescript-language-server # LSP
    nodePackages.vscode-langservers-extracted # LSP
    nodePackages.prettier # FORMATER
    nodePackages.eslint # Linters

  ];

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
