{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.social;
  username = import ../../username.nix;
  inherit (config.modules) graphics;
in {
  imports = [
    ./options.nix
  ];
  config = mkMerge [
    (mkIf (cfg.discord && (graphics.type != null)) {
      users.users.${username} = {
        packages = with pkgs; [
          (discord.override {
            withOpenASAR = true;
            withVencord = true;
          })
          vesktop
        ];
      };
    })
    (mkIf (cfg.slack && (graphics.type != null)) {
      users.users.${username} = {
        packages = with pkgs; [
          slack
        ];
      };
    })
  ];
}
