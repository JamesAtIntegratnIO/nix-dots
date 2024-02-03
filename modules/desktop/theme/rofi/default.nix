{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
  username = import ../../../../username.nix;
in {
  config = mkIf (cfg.desktop == "hyprland") {
    home-manager.users.${username}.xdg.configFile = {
      rofi-colors = {
        source = ./css/${cfg.theme.name}.rasi;
        target = "rofi/config/colors.rasi";
      };
    };
  };
}
