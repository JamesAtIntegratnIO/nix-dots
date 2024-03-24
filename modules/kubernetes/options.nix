{lib, ...}:
with lib; {
  options.modules.kubernetes = {
    enable = mkEnableOption "kubernetes";
    isMaster = mkOption {
      type = types.bool;
      default = false;
      description = "Whether this node is a master node";
    };
    kubeMasterIP = mkOption {
      type = types.str;
      default = "10.0.2.101";
      description = "The IP address of the master node";
    };
    kubeMasterHostname = mkOption {
      type = types.str;
      default = "k8s-master";
      description = "The hostname of the master node";
    };
    kubeMasterAPIServerPort = mkOption {
      type = types.int;
      default = 6443;
      description = "The port of the master node's API server";
    };
    kubePodCIDR = mkOption {
      type = types.str;
      default = "10.130.0.0/16";
      description = "The CIDR range for the pod network";
    };
    kubeServiceCIDR = mkOption {
      type = types.str;
      default = "10.140.0.0/16";
      description = "The CIDR range for the service network";
    };
    upstreamDNS = mkOption {
      type = types.str;
      default = "192.168.16.53";
      description = "The IP address of the upstream DNS server";
    };
  };
}
