{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  username = import ../../../../username.nix;
  cfg = config.modules.desktop;
in {
  config = mkIf (cfg.desktop == "hyprland") {
    home-manager.users.${username}.xdg.configFile = {
      theme-conf = {
        target = "hypr/colors.conf";
        source = ./${cfg.theme.name}.conf;
      };
    };
  };
}
