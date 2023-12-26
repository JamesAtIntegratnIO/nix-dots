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
    (mkIf (cfg.discord) {
      users.users.${username}.programs.discord.enable = true;
    })
  ];
}
