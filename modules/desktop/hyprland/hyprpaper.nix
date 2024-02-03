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
            preload = ~/.config/hypr/paper/pirate1.webp
            preload = ~/.config/hypr/paper/pirate2.webp
            preload = ~/.config/hypr/paper/pirate3.webp
            wallpaper = ,~/.config/hypr/paper/pirate1.webp
            ipc = off
          '';
          xdg.configFile = {
            "hypr/paper/wallpaper1.jpg".source = ./hyprpaper/wallpaper1.jpg;
            "hypr/paper/wallpaper2.jpg".source = ./hyprpaper/wallpaper2.jpg;
            "hypr/paper/pirate1.webp".source = ./hyprpaper/pirate1.webp;
            "hypr/paper/pirate2.webp".source = ./hyprpaper/pirate2.webp;
            "hypr/paper/pirate3.webp".source = ./hyprpaper/pirate3.webp;
          };
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
