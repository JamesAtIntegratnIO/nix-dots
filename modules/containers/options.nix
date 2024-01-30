{lib, ...}:
with lib; {
  options.modules.containers = {
    enable = mkEnableOption "enable";
    externalInterface = mkOption {
      type = types.str;
      default = "wlp5s0";
    };
    ollama = {
      enable = mkEnableOption "enable";
    };
    ollamaWebUI = {
      enable = mkEnableOption "enable";
    };
    sillytavern = {
      enable = mkEnableOption "enable";
    };
  };
}
