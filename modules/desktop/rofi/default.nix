{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  username = import ../../../username.nix;
  cfg = config.modules.desktop;
  rofi-wifi-menu = pkgs.writeScriptBin "rofi-wifi-menu" (builtins.readFile ./bin/rofi-wifi-menu.sh);
in {
  config = mkIf (cfg.desktop == "hyprland") {
    environment.systemPackages = with pkgs; [
      rofi-wifi-menu
      rofi-wayland
      rofi-power-menu
      rofi-bluetooth
    ];
    home-manager.users.${username}.xdg.configFile = {
      font-rasi = {
        source = ./config/font.rasi;
        target = "rofi/config/font.rasi";
      };
      launcher-bin = {
        source = ./bin/launcher.sh;
        target = "rofi/bin/launcher.sh";
      };
      launcher-rasi = {
        source = ./config/launcher.rasi;
        target = "rofi/config/launcher.rasi";
      };
      powermenu-bin = {
        source = ./bin/powermenu.sh;
        target = "rofi/bin/powermenu.sh";
      };
      powermenu-rasi = {
        source = ./config/powermenu.rasi;
        target = "rofi/config/powermenu.rasi";
      };
      confirm-rasi = {
        source = ./config/confirm.rasi;
        target = "rofi/config/confirm.rasi";
      };
      askpass-rasi = {
        source = ./config/askpass.rasi;
        target = "rofi/config/askpass.rasi";
      };
      runner-bin = {
        source = ./bin/runner.sh;
        target = "rofi/bin/runner.sh";
      };
      runner-rasi = {
        source = ./config/runner.rasi;
        target = "rofi/config/runnner.rasi";
      };
      bluetooth-rasi = {
        source = ./config/bluetooth.rasi;
        target = "rofi/config/bluetooth.rasi";
      };
      network-rasi = {
        source = ./config/network.rasi;
        target = "rofi/config/network.rasi";
      };
      networkmenu-rasi = {
        source = ./config/networkmenu.rasi;
        target = "rofi/config/networkmenu.rasi";
      };
      mpd-rasi = {
        source = ./config/mpd.rasi;
        target = "rofi/config/mpd.rasi";
      };
      screenshot-bin = {
        source = ./bin/screenshot.sh;
        target = "rofi/bin/screenshot.sh";
      };
      screenshot-rasi = {
        source = ./config/screenshot.rasi;
        target = "rofi/config/screenshot.rasi";
      };
    };
  };
}
