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
      security = {
        yubikey.enable = true;
      };
      services = {
        pipewire = true;
        printer = true;
      };
      social = {
        discord = true;
        slack = true;
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
        bluetooth.enable = true;
        ssh.enable = true;
        sshin.enable = true;
        firewall.enable = true;
        tailscale = {
          enable = true;
          permitCertUid = "boboysdadda@gmail.com";
        };
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
      # Will not work if pipewire is enabled (prefer pipewire)
      pulseaudio.enable = false;
      # Enable bluetooth hardware
      bluetooth.enable = true;
      # Enable cause sound don't work
      enableAllFirmware = true;
      # for the xbox controller
      xpadneo.enable = true;
      enableRedistributableFirmware = true;
      cpu.intel.updateMicrocode = true;
      opengl = {
        enable = true;
        driSupport32Bit = true;
        driSupport = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
  };
}
