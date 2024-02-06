{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  username = import ../../username.nix;
  sshPubKey = import ../../sshPubKey.nix;
  inherit (config.modules) graphics;
  cfg = config.modules.network;
in {
  imports = [./options.nix ./tailscale.nix];

  config = mkMerge [
    (mkIf (cfg.hostName != null) {
      networking.hostName = cfg.hostName;
    })
    (mkIf cfg.enable {
      networking = {
        dhcpcd = {
          enable = true;
          IPv6rs = false;
          extraConfig = ''
            noipv6rs
            noipv6
          '';
        };
        enableIPv6 = false;
        networkmanager = {
          enable = true;
          dhcp = "dhcpcd";
          appendNameservers = cfg.additionalNameServers;
          wifi = {
            backend = "wpa_supplicant";
            powersave = false;
          };
        };
      };
    })
    (mkIf (cfg.staticIP.address != null) {
      networking = {
        interfaces = {
          "${cfg.staticIP.interface}" = {
            ipv4.addresses = [
              {
                address = cfg.staticIP.address;
                prefixLength = cfg.staticIP.prefixLength;
              }
            ];
          };
        };
        defaultGateway = {
          address = cfg.staticIP.gateway;
          interface = cfg.staticIP.interface;
        };
      };
    })
    # ssh out
    (mkIf cfg.ssh.enable {
      environment.systemPackages = with pkgs; [
        sshs
      ];
    })
    # allow ssh in
    (mkIf cfg.sshin.enable {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
        ports = [22];
      };
      users.users.${username}.openssh.authorizedKeys.keys = [
        "${sshPubKey}"
      ];
    })

    (mkIf cfg.firewall.enable {
      networking.firewall = {
        enable = true;
        allowedTCPPorts = cfg.firewall.allowedTCPPorts;
        allowedUDPPorts = cfg.firewall.allowedUDPPorts;
      };
    })
    (mkIf cfg.disableIPv6 {
      networking = {
        enableIPv6 = false;
      };
    })
  ];
}
