{lib, ...}:
with lib; {
  options.modules.containers = {
    enable = mkEnableOption "enable";
    internalInterface = mkOption {
      type = types.str;
      default = "wlp5s0";
    };
    ollama = {
      enable = mkEnableOption "enable";
    };
    ollamaWebUI = {
      enable = mkEnableOption "enable";
    };
  };
}
