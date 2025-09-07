# zsh.nix

{ lib, config, pkgs, ... }: {

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
    # initExtra = '' source ~/.config/zsh/scripts/y.sh '';# B: does same but we slightly extra works. so we dont need it..
    initContent =
      "source ~/.config/zsh/scripts/y.sh "; # B: we are sourcing file we defined at the top of this config.

    shellAliases = let flakeDir = "~/flake";
    in {
      # G: Aliases 
      rm = "rm -i";
      gpu = "git push";
      cat = "bat";

      lsl = "eza -lagh --icons --group-directories-first --git --sort name";
      lsli = "eza -laihgH --icons --group-directories-first --git --sort name";
      lsd = "lazydocker";

      tt = "zellij";
      tth = "zellij -l welcome";
      tta = "zellij a";

      # Y:  NIX os 
      snrsf = "sudo nixos-rebuild switch --flake /etc/nixos#PredatorNix";
      deadNix = "nix-store --ge --print-dead";
      nixSize = "du -sh /nix/store/";
      nixVer =
        "sudo nix-env -p /nix/var/nix/profiles/system"; # Y: Use => {--list-generatoins, --delete-generatinos }
      nixOptimise = "sudo nix store optimise";
      # Y: Easy to learn but kept in case I forgot. 
      # nixGarbage="nix-collect-garbage";
      # nixGarbageD="nix-collect-garbage -d";

      unFree = "NIXPKGS_ALLOW_UNFREE=1";

      sw = "nh os switch";
      upd = "nh os switch --update";
      hms = "nh home switch";
      pkgs = "nvim ${flakeDir}/nixos/packages.nix";

      # DX: CONFIGS
      # IMP: config in nix.
      nixConfig = "sudo nvim /etc/nixos";
      zshConfig = "sudo nvim /etc/nixos/hosts/apps/zsh/default.nix";
      wbrConfig = "sudo nvim /etc/nixos/hosts/apps/waybar/default.nix";
      hyprConfig = "sudo nvim /etc/nixos/hosts/apps/hyprland/main.nix";
      kittyConfig = "sudo nvim /etc/nixos/hosts/apps/kitty.nix";
      # IMP: config inside nix repo and imported but non nix.
      ttConfig = "sudo nvim /etc/nixos/hosts/apps/.config_local/zellij/";
      # IMP: config in local but imported in nix.
      nvimConfig = "nvim /home/mukuldk/1_file/2_git_repos/nvim/";
      # IMP: config non NIX nor imported because they download there own files.
      yaziConfig = "nvim /home/mukuldk/.config/yazi/";

      # Y: Movements
      cdN = "cd /etc/nixos/";
      cdF = "cd /home/mukuldk/1_file/";
      cdG = "cd /home/mukuldk/1_file/2_git_repos/";
      cdD = "cd /home/mukuldk/1_file/5_ZenDownloads/";

      # Y: resource:
      resource = "source /home/mukuldk/.zshrc";

      # Y: costome
      # sysnmpp = "sudo systemctl start nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";
      # systnmpp = "sudo systemctl stop nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";
      sysd =
        "sudo systemctl start docker.service docker.socket && sudo systemctl status docker.service docker.socket";
      systd =
        "sudo systemctl stop docker.service docker.socket && sudo systemctl status docker.service docker.socket";

      chownMK =
        "sudo chown -R mukuldk:users ./* && sudo chown -R mukuldk:users ./.*";

      # Y: MCHOSE ace 68 FE
      mChose =
        "nix run nixpkgs#chromium -- --enable-experimental-web-platform-features";

      #======================================== DX: Linuwu-Sense |> 
      sensorsD = "watch -n 1 sensors";
      # Y: fan speeds numbers can be different in multyple of 5.
      fanFull =
        "echo '100,100' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
      fanAuto =
        "echo '0,0' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
      fanMid =
        "echo '50,50' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
      # Y: Battery 
      bat80 =
        "echo '1' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
      batFull =
        "echo '0' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
      batCalOn =
        "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
      batCalOff =
        "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
      usbCharge0 =
        "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/usb_charging"; # Y:  other values are 10 | 20 | 30. on respective %.
      # Y: Screen
      lcdOverDriveOn =
        "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/lcd_override";

      # Y: Keyboard
      rgbset =
        "echo '0,100,0,0,0,255,0,0,255,0,0,255,0,0,255' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/four_zone_mode";
      rgbTimeoutOn =
        "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";
      rgbTimeoutOff =
        "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";

      whichProfile = "cat /sys/firmware/acpi/platform_profile_choices";
      setProfile = "| sudo tee /sys/firmware/acpi/platform_profile";

      suM = "sudo su mukuldk";
      findJava = "readlink -f $(which java)";

      # bashConfig="nvim ~/.bashrc";
      # spfConfig="nvim ~/.config/superfile/config.toml";
      # dumpNvimConfig="cp -rv /home/mukuldk/.config/nvim /mnt/i/5.WSL/mukuldk"
      # dumpWezConfig="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /mnt/i/5.WSL/mukuldk"
      # dumpDotFiles="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.zshrc /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.config/zellij/config.kdl /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/ "
      # sysnmpp="sudo systemctl start nginx mysql php8.4-fpm "
      # systnmpp="sudo systemctl stop nginx mysql php8.4-fpm "
      # nvimConfig="sudo nvim /etc/nixos/hosts/apps/.config_local/nvim/"; # Y: keept here if i want to make it inside nix i will use it.

    };

  };
  # initExtra = ''
  #   export EDITOR="nvim"
  #   export VISUAL="nvim"
  # '';
}
