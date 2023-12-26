{lib, ...}:
with lib; {
  options.modules.dev = {
    enable = mkEnableOption "dev";
  };
}
