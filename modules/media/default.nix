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
    (mkIf (cfg.spotify == "spotify-tui") {
      environment.systemPackages = with pkgs; [
        spotify-tui
      ];
    })
    (mkIf (cfg.spotify == "spotifyd") {
      environment.systemPackages = with pkgs; [
        spotifyd
      ];
    })
    (mkIf (cfg.plex) {
      environment.systemPackages = with pkgs; [
        plex-media-player
      ];
    })
  ];
}
