{lib, ...}:
with lib; {
  options.modules.media = {
    spotify = mkOption {
      type = types.enum ["spotifyd" "spotify-tui" "spotify" null];
      default = null;
      description = ''
        Spotify client to use.
      '';
    };
    plex = mkEnableOption {
      default = false;
      description = ''
        Enable Plex media player.
      '';
    };
  };
}
