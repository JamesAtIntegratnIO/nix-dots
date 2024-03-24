{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.kubernetes;
  inherit (config.modules) network;
in {
  config = mkMerge [
    (mkIf (cfg.enable
      && !cfg.isMaster) {
      services.kubernetes = let
        api = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";
      in {
        roles = ["node"];
        # point kubelet and other services to kube-apiserver
        kubelet.kubeconfig.server = api;
      };
    })
  ];
}
