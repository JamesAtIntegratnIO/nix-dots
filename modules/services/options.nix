{lib, ...}:
with lib; {
  options.modules.services = {
    pipewire = mkOption {
      type = types.bool;
      description = "Pipewire audio server";
      default = false;
    };
    printer = mkEnableOption "Printer service";
    cockpit = mkEnableOption "Cockpit service";
    bluetooth = mkEnableOption "Bluetooth service";
    wayvnc = mkEnableOption "WayVNC service";
  };
}
