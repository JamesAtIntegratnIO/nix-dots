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
  imports = [
    ./hyprland
    ./kitty
    ./qt
    ./rofi
    ./waybar
  ];
  config = mkMerge [
    (mkIf (cfg.desktop == "hyprland") {
      })
  ];
}
