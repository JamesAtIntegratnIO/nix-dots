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
        style = "macchiato";
      };

      home-manager.users.${username}.xdg.configFile = {
        frappe-conf = {
          target = "qt5ct/colors/frappe.conf";
          source = ./css/frappe.conf;
        };
        latte-conf = {
          target = "qt5ct/colors/latte.conf";
          source = ./css/latte.conf;
        };
        macchiato-conf = {
          target = "qt5ct/colors/macchiato.conf";
          source = ./css/macchiato.conf;
        };
        mocha-conf = {
          target = "qt5ct/colors/mocha.conf";
          source = ./css/mocha.conf;
        };
      };
    })
  ];
}
