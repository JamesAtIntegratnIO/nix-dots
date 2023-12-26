{lib, ...}:
with lib; {
  options.modules.social = {
    discord = mkEnableOption "discord";
  };
}
