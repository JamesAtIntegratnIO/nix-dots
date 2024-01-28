{lib, ...}:
with lib; let
  username = import../../username.nix;
in {
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
    staticIP = {
      address = mkOption {
        type = types.str;
        default = "";
        description = ''
          The static IP address of the machine on the network.
        '';
      };
      example = "10.0.1.1";
      interface = mkOption {
        type = types.str;
        default = "eth0";
        description = ''
          The interface to assign the static IP address to.
        '';
        example = "eth0";
      };
      prefixLength = mkOption {
        type = types.int;
        default = 24;
        description = ''
          The prefix length of the static IP address.
        '';
        example = 24;
      };
      gateway = mkOption {
        type = types.str;
        default = "";
        description = ''
          The gateway of the static IP address.
        '';
        example = "10.0.0.1";
      };
    };

    additionalNameServers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        Additional nameservers to use.
      '';
      example = ["192.168.16.53"];
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
    tailscale = {
      enable = mkEnableOption "tailscale";
      permitCertUid = mkOption {
        type = types.str;
        default = "";
        description = ''
          The UID of the user that is allowed to read the Tailscale certificate.
          If empty, the certificate is readable by all users.
        '';
      };
      interfaceName = mkOption {
        type = types.str;
        default = "tailscale0";
        description = ''
          The name of the Tailscale interface.
        '';
      };
      routingFeatures = mkOption {
        type = types.enum ["none" "client" "server" "both"];
        default = "client";
        example = "server";
        description = ''
          Enables settings required for Tailscale's routing features like subnet routers and exit nodes.

          To use these these features, you will still need to call `sudo tailscale up` with the relevant flags like `--advertise-exit-node` and `--exit-node`.

          When set to `client` or `both`, reverse path filtering will be set to loose instead of strict.
          When set to `server` or `both`, IP forwarding will be enabled.
        '';
      };
      extraUpFlags = mkOption {
        type = types.listOf types.str;
        default = ["--operator=${username}" "--accept-dns" "--accept-routes" "--qr"];
        description = ''
          Extra flags to pass to `tailscale up`.
        '';
      };
    };
  };
}
