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
    (mkIf (cfg.ollama.enable) {
      users.users.ollama = {
        uid = 600;
        isSystemUser = true;
        group = "ollama";
      };

      users.groups.ollama = {
        gid = 600;
      };

      virtualisation.oci-containers.containers.ollama = {
        image = "ollama/ollama:latest";

        extraOptions = [
          "--gpus=all"
          "--runtime=nvidia"
          "--network=host"
        ];

        ports = ["11434"];

        environment = {
          NVIDIA_VISIBLE_DEVICES = "all";
          NVIDIA_DRIVER_CAPABILITIES = "all";
          OLLAMA_ORIGINS = "*";
          # PUID = "600";
          # PGID = "600";
        };

        volumes = [
          "/mnt/storage/ollama/ollama:/root/.ollama"
        ];
      };

      networking.firewall.allowedTCPPorts = [
        11434
      ];
    })
    (mkIf (cfg.ollamaWebUI.enable) {
      virtualisation.oci-containers.containers.ollamaWebUI = {
        image = "ghcr.io/ollama-webui/ollama-webui:main";

        extraOptions = [
          "--network=host"
        ];

        ports = ["8080"];

        environment = {
          OLLAMA_ORIGINS = "0.0.0.0";
          OLLAMA_API_BASE_URL = "http://localhost:11434/api";
          PUID = "600";
          PGID = "600";
        };
        volumes = [
          "/mnt/storage/ollama/ollama-webui:/app/backend/data"
        ];
      };

      networking.firewall.allowedTCPPorts = [
        8080
      ];
    })
  ];
}
