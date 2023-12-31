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
      graphics = {
        type = "intel";
      };
      security = {
        yubikey.enable = true;
      };
      social = {
        discord = true;
        slack = true;
      };
      network = {
        enable = true;
        hostName = "lappy";
        additionalNameServers = ["192.168.16.53"];
        bluetooth.enable = true;
        ssh.enable = true;
        firewall.enable = true;
        tailscale = {
          enable = true;
          permitCertUid = "boboysddda@gmail.com";
        };
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
    fileSystems."/mnt/kube_storage" = {
      device = "10.0.0.12:/mnt/user/kube_storage";
      fsType = "nfs";
      options = [
        "x-systemd.automount" # automount nfs
        "noauto" # only automount on first access
        "x-systemd.idle-timeout=600" # disconnect if not used for 10 minutes. automount will reconnect on next access
      ];
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
    };
  };
}
