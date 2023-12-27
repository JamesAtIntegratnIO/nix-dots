{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  lid = pkgs.writeScriptBin "lid.sh" ''
    #!/usr/bin/env zsh

    if [[ "$(hyprctl monitors)" =~ "\sDP-[0-9]+" ]]; then
      if [[ $1 == "open" ]]; then
        hyprctl keyword monitor "eDP-1,1920x1200,2560x0,1"
      else
        hyprctl keyword monitor "eDP-1,disable"
      fi
    fi
  '';

  username = import ../../../username.nix;
  cfg = config.modules.desktop;
in {
  imports = [
    ./config.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];
  config = mkMerge [
    (
      mkIf (cfg.desktop == "hyprland") {
        programs = {
          xwayland.enable = true;
          hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          };
        };
        fonts.fontconfig.enable = true;
        environment.systemPackages = with pkgs; [
          inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
        ];
        home-manager.users.${username} = {
          home.packages = with pkgs; [
            dolphin
            rofi
            dunst
            waybar
            lid
            font-awesome
          ];
          wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            systemd.enable = true;
          };
        };
        services = {
          xserver = {
            enable = true;
            layout = "us";
            xkbVariant = "";
            displayManager = {
              defaultSession = "hyprland";
              sddm = {
                enable = true;
              };
            };
          };
        };
      }
    )
  ];
}
