{lib, ...}:
with lib; {
  options.modules.virtualisation = {
    vmVariant = mkOption {
      type = types.listOf types.str;
      default = ["qemu"];
      example = ["qemu" "libvirtd"];
      description = ''
        The virtualisation variant to use.
      '';
    };
    containerVariant = mkOption {
      type = types.enum ["podman" "docker" null];
      default = null;
      description = ''
        The container variant to use.
      '';
    };
  };
}
