{lib, ...}:
with lib; {
  options.modules.browser = {
    firefox = mkEnableOption "firefox";
  };
}
