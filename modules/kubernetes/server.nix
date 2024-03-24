{
  lib,
  pkgs,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.modules.kubernetes;
  inherit (config.modules) network;
in {
  config = mkMerge [
    (mkIf (cfg.enable && cfg.isMaster) {
      services.kubernetes = {
        roles = ["master" "node"];
        apiserver = {
          securePort = cfg.kubeMasterAPIServerPort;
          advertiseAddress = cfg.kubeMasterIP;
          allowPrivileged = true;
          # Set the service network
          serviceClusterIpRange = cfg.kubeServiceCIDR;
        };
      };
    })
    (mkIf (cfg.enable
      && cfg.isMaster
      && network.firewall.enable) {
      networking.firewall = {
        allowedTCPPorts = [
          6443 # Kubernetes API
          10251 # Kube-scheduler
          10252 # Kube-controller-manager
          2379 # etcd
          2380 # etcd
        ];
        allowedUDPPorts = [
          8285 # Flannel
          8472 # Flannel
        ];
      };
    })
  ];
}
