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
    cockpit = mkEnableOption {
      description = ''
        Cockpit web interface
        https://cockpit-project.org/
      '';
      default = false;
    };
    bluetooth = mkEnableOption {
      description = "Bluetooth service";
      default = false;
    };
  };
}
