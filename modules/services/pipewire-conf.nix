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
        services.pipewire.configPackages = [
          (pkgs.writeTextDir "share/pipewire/pipewire-pulse.conf.d/15-auto-switch.conf" ''
            pulse.cmd = [
              { cmd = "load-module" args = "module-always-sink" flags = [ ] }
              { cmd = "load-module" args = "module-switch-on-connect" }
            ]
          '')
        ];
      }
    )
  ];
}
