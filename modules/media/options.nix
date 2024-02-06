{lib, ...}:
with lib; {
  options.modules.media = {
    spotify = mkOption {
      type = types.enum ["spotifyd" "spotify-tui" "spotify" null];
      default = null;
      description = "Spotify client to use.";
    };
    plex = mkEnableOption "plex";
    netflix = mkEnableOption "install netflix as dedicated chrome window";
  };
}
