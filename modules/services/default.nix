{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  username = import ../../username.nix;
  cfg = config.modules.services;
in {
  imports = [
    ./options.nix
    ./pipewire-conf.nix
  ];
  config = mkMerge [
    (mkIf (cfg.pipewire) {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber = {
          enable = true;
          package = pkgs.wireplumber;
        };
      };
      environment.systemPackages = with pkgs; [
        pulseaudioFull
      ];
      # Disable pulseaudio to avoid conflicts
      hardware.pulseaudio.enable = false;
    })
    (mkIf cfg.bluetooth {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
      };
    })
    (mkIf (cfg.printer) {
      services = {
        printing = {
          enable = true;
          drivers = with pkgs; [
            mfcl3770cdwlpr
            mfcl3770cdwcupswrapper
          ];
        };
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
    })
    (mkIf (cfg.cockpit) {
      services.cockpit = {
        enable = true;
        package = pkgs.cockpit;
        port = 9090;
        openFirewall = true;
      };
    })
  ];
}
