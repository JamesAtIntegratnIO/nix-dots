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
            Experimental = false;
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
          nssmdns = true;
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
    (mkIf (cfg.wayvnc) {
      environment.systemPackages = with pkgs; [
        wayvnc
      ];
      systemd.user.services.wayvnc = {
        description = "WayVNC";
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.wayvnc}/bin/wayvnc 0.0.0.0 5900";
          Restart = "always";
          RestartSec = 5;
        };
      };
      networking.firewall.allowedTCPPorts = [5900];
    })
    (mkIf (cfg.via) {
      services.udev.packages = with pkgs; [
        via
        qmk-udev-rules
      ];
      environment.systemPackages = with pkgs; [
        vial
      ];
    })
  ];
}
