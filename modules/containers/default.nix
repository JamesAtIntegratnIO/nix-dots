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
  inherit (config.modules) virtualisation;
in {
  imports = [./options.nix];

  config = mkMerge [
    (mkIf ((cfg.ollama.enable) && (virtualisation.containerVariant == "docker")) {
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
    (mkIf ((cfg.ollamaWebUI.enable) && (virtualisation.containerVariant == "docker")) {
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
    (mkIf ((cfg.qdrant.enable) && (virtualisation.containerVariant == "docker")) {
      virtualisation.oci-containers.containers.qdrant = {
        image = "qdrant/qdrant:latest";

        extraOptions = ["--network=host"];

        ports = ["6333" "6334"];

        volumes = [
          "/mnt/storage/ollama/qdrant:/qdrant/storage"
        ];
      };
    })
    (mkIf ((cfg.sillytavern.enable) && (virtualisation.containerVariant == "docker")) {
      virtualisation.oci-containers.containers.sillytavern = {
        image = "goolashe/sillytavern:latest";

        extraOptions = [
          "--network=host"
        ];

        ports = ["8000"];

        volumes = [
          "/mnt/storage/sillytavern/config:/home/node/app/config"
          "/mnt/storage/sillytavern/user:/home/node/app/public/user"
        ];
      };
      networking.firewall.allowedTCPPorts = [
        8000
      ];
    })
  ];
}
