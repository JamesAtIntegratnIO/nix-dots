{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.media;
  username = import ../../username.nix;
in {
  imports = [
    ./options.nix
  ];

  config = mkMerge [
    (mkIf (cfg.spotify == "spotifyd") {
      services.spotifyd = {
        enable = false;
      };
      networking.firewall = {
        allowedTCPPorts = [57621];
        allowedUDPPorts = [3353];
      };
    })
    (mkIf (cfg.plex) {
      environment.systemPackages = with pkgs; [
        plex-media-player
      ];
    })
    (mkIf (cfg.netflix) {
      environment.systemPackages = with pkgs; [
        netflix
      ];
    })
  ];
}
