{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.displayManager;
  username = import ../../username.nix;
  inherit (config.modules) desktop;
in {
  imports = [
    ./options.nix
  ];

  config = mkMerge [
    (mkIf (cfg.greeter == "sddm") {
      services = {
        xserver = {
          enable = true;
          layout = "us";
          xkbVariant = "";
          displayManager = {
            defaultSession = cfg.defaultSession;
            sddm = {
              enable = true;
            };
          };
        };
      };
    })
    (mkIf (cfg.greeter == "tuigreet") {
      environment.systemPackages = with pkgs; [
        greetd.tuigreet
      ];
      services = {
        xserver = {
          layout = "us";
        };
        greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${cfg.defaultSession}";
              user = username;
            };
          };
        };
      };
      # this is a life saver.
      # literally no documentation about this anywhere.
      # might be good to write about this...
      # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal"; # Without this errors will spam on screen
        # Without these bootlogs will spam on screen
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    })
  ];
}
