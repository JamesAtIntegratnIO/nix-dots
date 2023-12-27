{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.network;
in {
  config = mkIf (cfg.tailscale) {
    environment.systemPackages = [pkgs.tailscale];
    services.tailscale = {
      enable = true;
      permitCertUid = "boboysdadda@gmail.com";
      interfaceName = "tls0";
      port = 41641;
    };
    networking.firewall = {
      trustedInterfaces = ["tls0"];
      checkReversePath = "loose";
      allowedUDPPorts = [config.services.tailscale.port];
    };
  };
}
