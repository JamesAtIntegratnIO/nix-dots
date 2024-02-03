{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  username = import ../../../username.nix;
  cfg = config.modules.desktop;
in {
  config = mkMerge [
    (mkIf (cfg.desktop == "hyprland") {
      })
  ];
}
