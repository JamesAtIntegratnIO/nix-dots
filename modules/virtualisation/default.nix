{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  username = import ../../username.nix;
  cfg = config.modules.virtualisation;
  inherit (config.modules) graphics;
in {
  imports = [
    ./options.nix
    ./libvirtd.nix
  ];
  config = mkMerge [
    (mkIf (builtins.elem "qemu" cfg.vmVariant) {
      virtualisation.vmVariant = {
        # following configuration is added only when building VM with build-vm
        virtualisation = {
          memorySize = 4192;
          cores = 4;
        };
        virtualisation.qemu.options = [
          "-vga none"
          "-device virtio-vga-gl"
          "-display gtk,gl=on,show-cursor=off"
          "-audio pa,model=hda"
        ];
        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
        };
      };
    })
    (mkIf (cfg.containerVariant != null) {
      virtualisation = {
        containers.enable = true;
        containers.storage.settings = {
          storage = {
            driver = "overlay";
            runroot = "/run/containers/storage";
            graphroot = "/var/lib/containers/storage";
            rootless_storage_path = "/tmp/containers-$USER";
            options.overlay.mountopt = "nodev,metacopy=on";
          };
        };
      };
    })

    (mkIf (cfg.containerVariant == "podman") {
      virtualisation = {
        oci-containers.backend = "podman";
        podman = {
          enable = true;

          # Create a `docker` alias for podman, to use it as a drop-in replacement
          dockerCompat = true;
          # Make the Podman socket available in place of the Docker socket, so
          #  Docker tools can find the Podman socket.
          dockerSocket.enable = false;
          extraPackages = with pkgs; [
          ];

          autoPrune = {
            enable = true;
            dates = "weekly";
          };

          # # Required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
      };
      environment.systemPackages = with pkgs; [
        podman-tui
        podman-compose
        pods
      ];
    })
    (mkIf ((cfg.containerVariant == "docker") && (graphics.type == "nvidia")) {
      virtualisation.podman.enableNvidia = true;
    })
    (mkIf (cfg.containerVariant == "docker") {
      virtualisation = {
        oci-containers.backend = "docker";
        docker = {
          enable = true;
          enableNvidia = true;
        };
      };
      users.users.${username}.extraGroups = ["docker"];
    })
  ];
}
