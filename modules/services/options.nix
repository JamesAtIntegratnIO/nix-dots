{lib, ...}:
with lib; {
  options.modules.services = {
    pipewire = mkOption {
      type = types.bool;
      description = "Pipewire audio server";
      default = true;
    };
  };
}
