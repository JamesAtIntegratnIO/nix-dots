{lib, ...}:
with lib; {
  options.modules.security = {
    yubikey = {
      enable = mkEnableOption "Yubikey";
    };
  };
}
