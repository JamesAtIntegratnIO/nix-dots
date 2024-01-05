{lib, ...}:
with lib; {
  options.modules.virtualisation = {
    vmVariant = mkOption {
      type = types.enum ["qemu" null];
      default = "qemu";
      description = ''
        The virtualisation variant to use.
      '';
    };
    containerVariant = mkOption {
      type = types.enum ["podman" null];
      default = null;
      description = ''
        The container variant to use.
      '';
    };
  };
}
