{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  username = import ../../username.nix;
  cfg = config.modules.containers;
in {
  imports = [./options.nix];

  config = mkMerge [
    (mkIf (cfg.enable) {
      networking.nat = {
        enable = true;
        internalInterfaces = [cfg.internalInterface];
        externalInterface = "br0";
      };
    })
    (mkIf (cfg.ollama.enable) {
      users.users.ollama = {
        uid = 600;
        isSystemUser = true;
        group = "ollama";
      };
      users.groups.ollama = {
        gid = 600;
      };

      containers.ollama = {
        autoStart = true;
        privateNetwork = true;
        config = {
          config,
          pkgs,
          ...
        }: {
          services.ollama = {
            enable = true;
            listenAddress = "0.0.0.0:11434";
          };
          networking = {
            firewall = {
              enable = true;
              allowedTCPPorts = [11434];
            };
          };
        };
      };
    })
  ];
}
