{lib, ...}:
with lib; {
  options.modules.services = {
    pipewire = mkOption {
      type = types.bool;
      description = "Pipewire audio server";
      default = false;
    };
    printer = mkEnableOption {
      description = "Printer service";
      default = false;
    };
  };
}
