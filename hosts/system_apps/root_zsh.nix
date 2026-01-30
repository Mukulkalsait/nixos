# Y:  define the users
{ pkgs, ... }: {

  users.users.root = {
    shell = pkgs.zsh {
      # enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };


  # "/root/y.sh".source = ../apps/zsh/scripts/y.sh; #yaxi = y script
  # initContent = "source ~/y.sh "; # B: we are sourcing file we defined at the top of this config.

  # Root-only minimal zsh config
  environment.etc."zshrc-root".text = ''
      # ---- ROOT ZSH MINIMAL ----

      # Safety
      setopt NO_RM_STAR_SILENT
      setopt HIST_IGNORE_DUPS
      setopt HIST_REDUCE_BLANKS
      unsetopt BEEP

      # History (local only)
      HISTFILE=/root/.zsh_history
      HISTSIZE=500
      SAVEHIST=500

      # Minimal PATH (avoid user junk)
      export PATH=/run/current-system/sw/bin:/root/.nix-profile/bin

      # Minimal aliases
      alias ll='ls -lh'
      alias lsl='eza -lagh --icons --group-directories-first --git --sort name'
      alias nixConfig='nvim /etc/nixos'
      alias setProfile='tee /sys/firmware/acpi/platform_profile'
      alias tt='zellij'
      alias rebuild='nixos-rebuild switch'
      alias snrsf='echo "sudo nixos-rebuild switch --flake /etc/nixos#PredatorNix"'
    alias unFree = 'NIXPKGS_ALLOW_UNFREE=1'
  '';

  # Tell zsh to load root config only for root
  programs.zsh.shellInit = ''
    if [[ "$USER" == "root" ]];
    then
    source /etc/zshrc-root
    return
    fi
  '';

}


