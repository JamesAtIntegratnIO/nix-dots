{lib, ...}:
with lib; {
  options.modules.network = {
    enable = mkEnableOption "enable";
    hostName = mkOption {
      type = types.str;
      default = "nixos";
      description = ''
        The hostname of the machine on the network.
      '';
      example = "nixos";
    };
    additionalNameServers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        Additional nameservers to use.
      '';
      example = ["192.168.16.53"];
    };
    bluetooth = {
      enable = mkEnableOption "bluetooth";
    };
    ssh = {
      enable = mkEnableOption "ssh";
    };
    sshin = {
      enable = mkEnableOption "sshin";
    };
    firewall = {
      enable = mkEnableOption "firewall";
      allowedTCPPorts = mkOption {
        type = types.listOf types.int;
        default = [22];
        description = ''
          List of TCP ports to allow incoming connections to.
        '';
        example = [22 80 443];
      };
      allowedUDPPorts = mkOption {
        type = types.listOf types.int;
        default = [];
        description = ''
          List of UDP ports to allow incoming connections to.
        '';
        example = [53];
      };
    };
    tailscale = mkEnableOption "tailscale";
  };
}
