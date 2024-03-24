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
  imports = [
    ./options.nix
    ./server.nix
    ./worker.nix
  ];

  config = mkMerge [
    (mkIf cfg.enable {
      networking = {
        extraHosts = "${cfg.kubeMasterIP} ${cfg.kubeMasterHostname}";
        networkmanager.enable = mkForce false;
      };

      services.kubernetes = {
        masterAddress = cfg.kubeMasterHostname;
        apiserverAddress = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";
        easyCerts = true;
        kubelet.clusterDns = (
          concatStringsSep "." (
            take 3 (splitString "." cfg.kubeServiceCIDR)
          )
          + ".254"
        );
        # Set the pod network
        clusterCidr = cfg.kubePodCIDR;

        addons.dns = {
          enable = true;
          corefile = ''
            .:10053 {
              errors
              health :10054
              kubernetes cluster.local in-addr.arpa ip6.arpa {
                pods insecure
                fallthrough in-addr.arpa ip6.arpa
              }
              prometheus :10055
              forward . ${toString cfg.upstreamDNS}:53
              cache 30
              loop
              reload
              loadbalance
            }'';
        };
      };
    })
    (mkIf (cfg.enable
      && network.firewall.enable) {
      networking.firewall = {
        allowedTCPPorts = [
          80 # HTTP
          443 # HTTPS
          10250 # Kubelet
        ];
        allowedUDPPorts = [
          8285 # Flannel
          8472 # Flannel
        ];
      };
    })
  ];
}
