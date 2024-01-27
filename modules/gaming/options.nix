{lib, ...}:
with lib; {
  options.modules.gaming = {
    enable = mkEnableOption "gaming";
    steam = mkEnableOption "steam";
    lutris = mkEnableOption "lutris";
    wine = mkEnableOption "wine";
  };
}
