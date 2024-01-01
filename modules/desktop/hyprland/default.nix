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

  rofi-wifi-menu = pkgs.writeScriptBin "rofi-wifi-menu" (builtins.readFile ./rofi-wifi-menu.sh);
in {
  imports = [
    ./config.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./nwg-panel.nix
    ./hyprland-monitor-attached.nix
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
          rofi-wifi-menu
        ];
        # This line is the magic that makes gtklock work
        security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

        home-manager.users.${username} = {
          home.packages = with pkgs; [
            dolphin
            rofi-wayland
            rofi-power-menu
            rofi-bluetooth
            brightnessctl
            dunst
            lid
            font-awesome
            gtklock
            nerdfonts
            swayidle
            xdg-utils
          ];
          wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            systemd.enable = true;
          };
          xdg.configFile = {
            "hypr/rokid-attached.sh".source = ./rokid-attached.sh;
            "hypr/rokid-detached.sh".source = ./rokid-detached.sh;
          };
        };
      }
    )
  ];
}
