{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.network;
in {
  config = mkIf (cfg.tailscale.enable) {
    environment.systemPackages = [pkgs.tailscale];
    services.tailscale = {
      enable = true;
      permitCertUid = cfg.tailscale.permitCertUid;
      interfaceName = cfg.tailscale.interfaceName;
      port = 41641;
      openFirewall = true;
      useRoutingFeatures = cfg.tailscale.routingFeatures;
      extraUpFlags = cfg.tailscale.extraUpFlags;
    };
  };
}
