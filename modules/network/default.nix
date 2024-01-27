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
        networkmanager = {
          enable = true;
          appendNameservers = cfg.additionalNameServers;
          wifi = {
            backend = "wpa_supplicant";
          };
        };
        # wireless.userControlled.enable = true;
      };
    })
    (mkIf cfg.bluetooth.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
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
        passwordAuthentication = false;
        permitRootLogin = "no";
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
  ];
}
