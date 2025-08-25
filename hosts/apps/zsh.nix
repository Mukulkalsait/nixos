# zsh.nix

{ lib, config, pkgs, ...}:
{

 # Zsh with **working** completion, no weird aliases
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    shellAliases = 
    let 
    flakeDir = "~/flake"; 
    in 
    {
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";
        pkgs = "nvim ${flakeDir}/nixos/packages.nix";

        lsl = "eza -la";
        cat = "bat";

        # r = "ranger";
        # v = "nvim";
        # se = "sudoedit";
        # microfetch = "microfetch && echo";
        # gs = "git status";
        # ga = "git add";
        # gc = "git commit";
        # ".." = "cd ..";

        gpu = "git push";

      };

   # oh-my-zsh = {
   #  enable = true;
   #  plugins = [ "git" "sudo" ];
   #  theme = "robbyrussell";
   # };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    # initExtra = ''
    #   # Start Tmux automatically if not already running. No Tmux in TTY
    #   if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
    #     tmux attach-session -t default || tmux new-session -s default
    #   fi
    #
    #   # Start UWSM
    #   if uwsm check may-start > /dev/null && uwsm select; then
    #     exec systemd-cat -t uwsm_start uwsm start default
    #   fi
    # '';
  };


# ===========================================================


  # programs.fzf = {
  # enable = true;
  # enableZshIntegration = true;
  # };
  
  
  # programs.zoxide = {
  # enable = true;
  # enableZshIntegration = true; # provides `z` command without touching `cd`
  # };
}
