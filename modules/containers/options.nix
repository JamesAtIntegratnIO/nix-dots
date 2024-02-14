{lib, ...}:
with lib; {
  options.modules.containers = {
    enable = mkEnableOption "enable";
    externalInterface = mkOption {
      type = types.str;
      default = "wlp5s0";
      description = "The network interface to use for external traffic";
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
    qdrant = {
      enable = mkEnableOption "enable qdrant vector store";
    };
  };
}
