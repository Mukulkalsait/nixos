# Y:  ~/.config/zsh/zsh.nix

{ lib, config, pkgs, ... }: {

  # Y: 👇 in .config/zsh/scripts/y.sh put this file 👇
  #
  home.file.".config/zsh/scripts/y.sh".source = ./scripts/y.sh; #yaxi = y script

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 100000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    # Y: Commands to run as soon as zsh loaded 🔻
    # initExtra = '' source ~/.config/zsh/scripts/y.sh '';# B: does same but we slightly extra works. so we dont need it..
    initContent =
      "source ~/.config/zsh/scripts/y.sh "; # B: we are sourcing file we defined at the top of this config.

    shellAliases =
      let flakeDir = "~/flake";
      in {

        clip = "cliphist list | rofi -dmenu -p 'Clip' | cliphist decode | wl-copy";
        # wA = "bat /home/mukuldk/.config/zsh/.zshrc";
        # G: Aliases 
        rm = "rm -iv";
        gpu = "git push";
        cat = "bat";

        lsl = "eza -lagh --icons --group-directories-first --git --sort name";
        lsli = "eza -laihgH --icons --group-directories-first --git --sort name";
        # lsd = "lazydocker";
        pti = "podman-tui";
        gmd = "gomanagedocker p";
        dive = "dive --source podman";
        rustMaintain = "rustup update && rustup component add rust-analyzer rust-src clippy rustfmt && rustup component add clippy --toolchain nightly ";

        tt = "zellij";
        tth = "zellij -l welcome";
        tta = "zellij a";

        # Y:  NIX os 
        snrsf = "sudo nixos-rebuild switch --flake /etc/nixos#PredatorNix";
        deadNix = "nix-store --ge --print-dead";
        nixSize = "dust -sh /nix/store/";
        nixSizeFull = "dua i -sh /nix/store/";
        nixVer =
          "sudo nix-env -p /nix/var/nix/profiles/system"; # Y: Use => {--list-generatoins, --delete-generatinos }
        nixOptimise = "sudo nix store optimise";
        nixCopy = "sudo rm -rfv /home/mukuldk/nixos_copy/* && sudo cp -rv /etc/nixos* /home/mukuldk/nixos_copy/ && sudo chown -R mukuldk:mukuldk /home/mukuldk/nixos_copy && sudo chmod -R 776 /home/mukuldk/nixos_copy";
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
        sshConfig = "nvim /home/mukuldk/.ssh/config";
        catZ = "cat /home/mukuldk/.config/zsh/.zshrc";
        # B: DarkNet-Starter
        DarkNet = "cd /home/mukuldk/MicroVM/ && nix run /etc/nixos#nixosConfigurations.browser-vm.config.microvm.declaredRunner";

        # Y: Movements
        cdN = "cd /etc/nixos/";
        cdF = "cd /home/mukuldk/1_file/";
        cdG = "cd /home/mukuldk/1_file/2_git_repos/";
        cdD = "cd /home/mukuldk/1_file/5_ZenDownloads/";

        # Y: resource:
        resource = "source /home/mukuldk/.config/zsh/.zshrc";

        # Y: costome
        # sysnmpp = "sudo systemctl start nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";
        # systnmpp = "sudo systemctl stop nginx php8.4-fpm && sudo systemctl status nginx php8.4-fpm ";

        chownMK =
          "sudo chown -R mukuldk:users ./* && sudo chown -R mukuldk:users ./.*";

        # Y: MCHOSE ace 68 FE
        mChose =
          "nix run nixpkgs#ungoogled-chromium -- --enable-experimental-web-platform-features  --enable-easy-off-store-extension-install %U ";
        mycli = "nix shell nixpkgs#mycli -c mycli";

        whichProfiles = "cat /sys/firmware/acpi/platform_profile";
        allProfiles = "cat /sys/firmware/acpi/platform_profile_choices";
        setProfile = "sudo tee /sys/firmware/acpi/platform_profile";

        #======================================== DX: Linuwu-Sense |> 
        sensorsD = "watch -n 1 sensors";
        # Y: fan speeds numbers can be different in multyple of 5.
        # fanAuto = "echo '0,0' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan1 = "echo '20,20' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan2 = "echo '30,30' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan3 = "echo '50,50' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan4 = "echo '60,60' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan5 = "echo '70,70' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fan6 = "echo '80,80' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # fanFull = "echo '100,100' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/fan_speed";
        # Y: Battery 
        # bat80 = "echo '1' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
        # batFull = "echo '0' | sudo ${pkgs.coreutils}/bin/tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";
        # batLimit = "cat /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_limiter";

        # batCal = "cat /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
        # batCalOn = "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
        # batCalOff = "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/battery_calibration";
        # usbCharge0 = "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/usb_charging"; # Y:  other values are 10 | 20 | 30. on respective %.
        # Y: Screen
        # lcdCheck = "cat /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/lcd_override";
        # lcdOverDriveOn = "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/lcd_override";

        # Y: Keyboard
        # rgbset = "echo 3,1,100,2,0,0,0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode";
        # rgbTimeoutOn = "echo 1 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";
        # rgbTimeoutOff = "echo 0 | sudo tee /sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/predator_sense/backlight_timeout";


        # Y: Languages : fcitx5 vx normal
        multyLang = "fcitx5 &";
        lang0 = "pkill fcitx5";

        suM = "sudo su mukuldk";
        findJava = "readlink -f $(which java)";

        # IMP: DevOps Engeneering.
        sysp = "sudo systemctl start podman.socket podman.service && sudo systemctl status podman.socket podman.service"; # Start Podman
        systp = "sudo systemctl stop podman.socket podman.service && sudo systemctl status podman.socket podman.service"; # Stop Podman (stops Minikube too)


        kl = "kubectl ";

        kla = "kubectl apply -f ";
        klar = "kubectl api-resources ";
        klat = "kubectl attach ";

        klci = "kubectl cluster-info ";
        kld = "kubectl describe ";

        kle = "kubectl exec ";
        klei = "kubectl exec -it ";

        klg = "kubectl get ";
        kls = "kubectl scale ";
        klr = "kubectl scale ";



        klh = "echo '
                 Alias Help 
         _________________________ 
        |                         |
        | kla(apply) -f           |
        | klar(api-Resources)     |
        | klat(attach)            |
        |                         |
        | klci(cluster-Info)      |
        | kld(describe)           |
        |                         |
        | kle(exec)               |
        | klei(exec -it)          |
        |                         |
        | klg(get)                |
        | kls(scale)              |
        | klr(rollout)            |
        |                         |
        |_________________________|

        '"; # HELP

        # kubeOn = "minikube start --driver=podman "; # Y: provide =>  --cpus= --memory= 
        # kubeOnX = "minikube start --driver=podman --cpus=4 --memory=8g && echo 'minikube start --driver=podman --cpus=4 --memory=8g'"; # Start Minikube
        # kubeOnY = "minikube start --driver=podman --container-runtime=crun --cpus=2 --memory=8192 && echo '--driver=podman --container-runtime=crun --cpus=2 --memory=8192' ";
        # kubeOnDebug = "echo 'add |>  --alsologtostderr -v=9 {where -v is 1-10 scale for debuging }'";
        #
        # kubeOff = "minikube stop"; # Stop Minikube
        # miniSet = "minikube config set rootless true && minikube config set driver podman && minikube config view";
        #
        # minikubeDelete = "minikube delete";
        # minikubeDeleteFull = "minikube delete --all --purge &&  rm -rfv ~/.minikube";

        # DX: Docker 
        # sysd = "sudo systemctl start docker.service docker.socket && sudo systemctl status docker.service docker.socket";
        # systd = "sudo systemctl stop docker.service docker.socket && sudo systemctl status docker.service docker.socket";

        # bashConfig="nvim ~/.bashrc";
        # spfConfig="nvim ~/.config/superfile/config.toml";
        # dumpNvimConfig="cp -rv /home/mukuldk/.config/nvim /mnt/i/5.WSL/mukuldk"
        # dumpWezConfig="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /mnt/i/5.WSL/mukuldk"
        # dumpDotFiles="cp -rv /mnt/c/Users/mdk12/.wezterm.lua /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.config/zsh/.zshrc /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/  && cp -rv /home/mukuldk/.config/zellij/config.kdl /home/mukuldk/1Home/1.Configs_All/2.config_Online/dotfiles-test/userFolder/ "
        # sysnmpp="sudo systemctl start nginx mysql php8.4-fpm "
        # systnmpp="sudo systemctl stop nginx mysql php8.4-fpm "
        # nvimConfig="sudo nvim /etc/nixos/hosts/apps/.config_local/nvim/"; # Y: keept here if i want to make it inside nix i will use it.
        # Y:  APPS 
        # Davinci-resolve
        davinci-resolve = "QT_QPA_PLATFORM=xcb davinci-resolve";

      };

  };
  # initExtra = ''
  #   export EDITOR="nvim"
  #   export VISUAL="nvim"
  # '';
}
