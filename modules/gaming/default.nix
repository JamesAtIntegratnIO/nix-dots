{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gaming;
  username = import ../../username.nix;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.steamCompat
  ];

  config = mkMerge [
    (mkIf cfg.enable {
      services.pipewire = {
        lowLatency = {
          enable = true;
          quantum = 64;
          rate = 48000;
        };
      };
    })
    (mkIf cfg.steam {
      environment.systemPackages = with pkgs; [
        protontricks
      ];
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = with pkgs; [
          steamtinkerlaunch
          gamescope
          inputs.nix-gaming.packages.${pkgs.system}.proton-ge
        ];
      };
      hardware.opengl.driSupport32Bit = true;
    })
    (mkIf cfg.wine {
      environment.systemPackages = with pkgs; [
        winetricks
        wine-wayland
      ];
    })
    (mkIf cfg.lutris {
      environment.systemPackages = with pkgs; [
        lutris
      ];
      hardware.opengl.driSupport32Bit = true;
    })
  ];
}
