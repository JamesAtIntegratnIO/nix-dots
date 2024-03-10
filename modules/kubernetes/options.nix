{lib, ...}:
with lib; {
  options.modules.kubernetes = {
    enable = mkEnableOption "kubernetes";
    isMaster = mkOption {
      type = types.bool;
      default = false;
      description = "Whether this node is a master node";
    };
  };
}
