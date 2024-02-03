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
  config = mkMerge [
    (mkIf (cfg.desktop == "hyprland") {
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = cfg.theme.style;
      };

      home-manager.users.${username}.xdg.configFile = {
        frappe-conf = {
          target = "qt5ct/colors/Catppuccin-Frappe.conf";
          source = ./css/frappe.conf;
        };
        latte-conf = {
          target = "qt5ct/colors/Catppuccin-Latte.conf";
          source = ./css/latte.conf;
        };
        macchiato-conf = {
          target = "qt5ct/colors/Catppuccin-Macchiato.conf";
          source = ./css/macchiato.conf;
        };
        mocha-conf = {
          target = "qt5ct/colors/Catppuccin-Mocha.conf";
          source = ./css/mocha.conf;
        };
      };
    })
  ];
}
