{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  username = import ../../../username.nix;
  cfg = config.modules.desktop;
in {
  config = mkMerge [
    (
      mkIf (cfg.desktop == "hyprland") {
        home-manager.users.${username} = {
          # home.packages = with pkgs; [
          #   hyprpaper
          # ];

          xdg.configFile."hypr/paper".source = ./hyprpaper;
          xdg.configFile."hypr/hyprpaper.conf".text = ''
            preload = ~/.config/hypr/paper/wallpaper1.jpg
            preload = ~/.config/hypr/paper/wallpaper2.jpg
            wallpaper = ,!/.config/hypr/paper/wallpaper1.jpg
          '';
        };

        systemd.user.services.hyprpaper = {
          description = "hyprpaper";
          wantedBy = ["hyprland-session.target"];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
            Restart = "on-failure";
          };
        };
      }
    )
  ];
}
