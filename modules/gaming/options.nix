{lib, ...}:
with lib; {
    options.modules.gaming = {
        eanble = mkEnableOption "gaming";
        steam = mkEnableOption "steam";
        lutris = mkEnableOption "lutris";
    }
}