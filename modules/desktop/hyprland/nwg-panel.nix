### This isn't working right now.
# TODO: fix this
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
  username = import ../../../username.nix;
in {
  config = mkMerge [
    (mkIf ((cfg.desktop == "hyprland") && (cfg.panel == "nwg-panel")) {
      environment.systemPackages = with pkgs; [
        nwg-panel
        wlr-randr
        light
        noto-fonts-color-emoji
      ];
      # systemd.user.services.nwg-panel = {
      #   description = "nwg-panel";
      #   wantedBy = ["graphical-session.target"];
      #   after = ["graphical-session.target"];
      #   partOf = ["graphical-session.target"];
      #   serviceConfig = {
      #     Type = "simple";
      #     # ExecCondition = "/bin/sh -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
      #     ExecStart = "${pkgs.nwg-panel}/bin/nwg-panel";
      #     Restart = "always";
      #   };
      # };
    })
  ];
}
