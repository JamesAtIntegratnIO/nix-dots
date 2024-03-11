{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services;
in {
  config = mkMerge [
    (
      mkIf
      (cfg.pipewire) {
        environment.etc = let
          json = pkgs.formats.json {};
        in {
          "pipewire/pipewire-pulse.conf.d/15-auto-switch.conf".text = ''
            pulse.cmd = [
              { cmd = "load-module" args = "module-always-sink" flags = [ ] }
              { cmd = "load-module" args = "module-switch-on-connect" }
            ]
          '';
        };
      }
    )
  ];
}
