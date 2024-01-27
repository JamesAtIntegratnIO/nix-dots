{lib, ...}:
with lib; {
  options.modules.graphics = {
    type = mkOption {
      type = types.enum [null "intel" "nvidia"];
      default = null;
      description = "Enable GUI: allows to use graphical applications";
      example = "intel";
    };
  };
}
