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
      "kitty/colors.conf" = {
        source = ./${cfg.theme.name}.conf;
      };
      "kitty/kitty.conf" = {
        text = ''
          include colors.conf

          background_opacity          0.95
          background_blur             30

          tab_bar_min_tabs            1
          tab_bar_edge                bottom
          tab_bar_style               powerline
          tab_powerline_style         slanted
          tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else ' '}
        '';
      };
    };
  };
}
