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
      kubernetes = {
        enable = true;
        isMaster = false;
      };
      network = {
        enable = true;
        hostName = "k8s-worker1";
        staticIP = {
          interface = "eth0";
          address = "10.0.2.102";
          prefixLength = 9;
          gateway = "10.0.0.1";
        };
        additionalNameServers = ["192.168.16.53"];
        ssh.enable = true;
        sshin.enable = true;
        firewall = {
          enable = false;
          allowedTCPPorts = [22 80 443 6443 8888];
        };
        tailscale = {
          enable = true;
          permitCertUid = "boboysdadda@gmail.com";
        };
      };
    };
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/home/boboysdadda/.ssh/id_ed25519"
      ];
    };
    networking.firewall.enable = false;
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
    };
  };
}
