# zsh.nix

{ lib, config, pkgs, ...}:
{

  # Y: 👇 in .comfig/zsh/scripts/y.sh put this file 👇
  home.file.".config/zsh/scripts/y.sh".source = ./scripts/y.sh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    # Y: Commands to run as soon as zsh loaded 🔻 
    initExtra = '' source ~/.config/zsh/scripts/y.sh '';# B: we are sourcing file we defined at the top of this config.

    shellAliases = 
    let 
    flakeDir = "~/flake"; 
    in 
    {
        # G: Aliases 
        rm="rm -i";
        gpu = "git push";
        cat = "bat";

        lsl="eza -lagh --icons --group-directories-first --git --sort name";
        lsli="eza -laihgH --icons --group-directories-first --git --sort name";

        tt="zellij";
        tth="zellij -l welcome";
        tta="zellij a";

        snrsf="sudo nixos-rebuild switch --flake /etc/nixos#PredatorNix";
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";
        pkgs = "nvim ${flakeDir}/nixos/packages.nix";

        nixConfig="sudo nvim /etc/nixos";
        nvimConfig="nvim /home/mukuldk/1_file/2_git_repos/nvim/";
        zshConfig="sudo nvim /etc/nixos/hosts/apps/zsh.nix";
        hyprConfig="sudo nvim /etc/nixos/hosts/apps/hyprland/main.nix";
        kittyConfig="sudo nvim /etc/nixos/hosts/apps/kitty.nix";

        # ttConfig="nvim ~/.config/zellij/config.kdl";
        # yaziConfig="sudo nvim /etc/nixos/hosts/apps/";
        
        cdN="cd /etc/nixos/";
        cdF="cd /home/mukuldk/1_file/";
        cdG="cd /home/mukuldk/1_file/2_git_repos/";
        cdD="cd /home/mukuldk/1_file/5_ZenDownloads/";

        sysnmpp="sudo systemctl start nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";
        systnmpp="sudo systemctl stop nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";
        # sysnmpp="sudo systemctl start nginx mysql php8.4-fpm "
        # systnmpp="sudo systemctl stop nginx mysql php8.4-fpm "

        suM="sudo su mukuldk";
        findJava="readlink -f $(which java)";

        # bashConfig="nvim ~/.bashrc";
        # spfConfig="nvim ~/.config/superfile/config.toml";
        # chownAll="sudo chown -R {user}:{group} ./*"
        # chownAllM="sudo chown -R {user}:{group} ./*"
        # dumpNvimConfig="cp -rv /home/mukuldk/.config/nvim /mnt/i/5.WSL/mukuldk"
        # dumpWezConfig="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /mnt/i/5.WSL/mukuldk"
        # dumpDotFiles="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.zshrc /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.config/zellij/config.kdl /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/ "

      };

   # oh-my-zsh = {
   #  enable = true;
   #  plugins = [ "git" "sudo" ];
   #  theme = "robbyrussell";
   # };

  };
}
