{
  pkgs,
  self,
  inputs,
  ...
}: let
  username = import ../../username.nix;
in {
  imports = [
    ../../modules
    inputs.agenix.nixosModules.default
    inputs.nixvim.nixosModules.nixvim
  ];
  config = {
    modules = {
      browser = {
        firefox = true;
      };
      containers = {
        enable = true;
        externalInterface = "wlp5s0";
        ollama = {
          enable = true;
        };
        ollamaWebUI = {
          enable = true;
        };
        sillytavern = {
          enable = true;
        };
      };
      desktop = {
        desktop = "hyprland";
        panel = "waybar";
      };
      displayManager = {
        greeter = "tuigreet";
        defaultSession = "Hyprland";
      };
      dev = {
        enable = true;
        langs = ["golang"];
        devops.tools = ["kubernetes"];
      };
      editor = {
        enable = true;
        vscode = true;
        lunarvim = true;
        neovim = true;
      };
      gaming = {
        enable = true;
        steam = true;
        lutris = true;
        wine = true;
      };
      graphics = {
        type = "nvidia";
      };
      media = {
        spotify = "spotify-tui";
        plex = true;
      };
      network = {
        enable = true;
        hostName = "gamer";
        staticIP = {
          interface = "wlp5s0";
          address = "10.0.1.1";
          prefixLength = 9;
          gateway = "10.0.0.1";
        };
        additionalNameServers = ["192.168.16.53"];
        ssh.enable = true;
        sshin.enable = true;
        firewall.enable = true;
        tailscale = {
          enable = true;
          permitCertUid = "boboysdadda@gmail.com";
        };
      };
      security = {
        yubikey.enable = true;
      };
      services = {
        pipewire = true;
        printer = true;
        cockpit = true;
        bluetooth = true;
        wayvnc = true;
      };
      social = {
        discord = true;
        slack = true;
      };

      virtualisation = {
        containerVariant = "docker";
      };
    };
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/home/boboysdadda/.ssh/id_ed25519"
      ];
      secrets.pfsense_ca = {
        file = ../../secrets/lappy-pfsense-ca.age;
        name = "/ssl/pfsense-ca.pem";
        mode = "444";
      };
    };
    fileSystems = {
      "/mnt/kube_storage" = {
        device = "10.0.0.12:/mnt/user/kube_storage";
        fsType = "nfs";
        options = [
          "x-systemd.automount" # automount nfs
          "noauto" # only automount on first access
          "x-systemd.idle-timeout=600" # disconnect if not used for 10 minutes. automount will reconnect on next access
        ];
      };
      "/mnt/storage" = {
        device = "/dev/disk/by-label/GAMES";
        fsType = "ext4";
      };
    };
    hardware = {
      # For zsa keyboards
      keyboard.zsa.enable = true;
      # Enable cause sound don't work
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
      cpu.intel.updateMicrocode = true;
    };
  };
}
