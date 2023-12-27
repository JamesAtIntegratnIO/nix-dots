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
      };
      dev = {
        enable = true;
        langs = ["golang"];
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

    boot = {
      kernelPackages = pkgs.linuxPackages_6_1;
      # Bootloader.
      loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };
      # Enable building for ARM
      binfmt.emulatedSystems = ["aarch64-linux"];
      # Setup keyfile
      # initrd.secrets = {
      #   "/crypto_keyfile.bin" = null;
      # };
      extraModprobeConfig = ''options bluetooth disable_ertm=1 '';
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
    };
  };
}
