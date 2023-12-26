{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  username = import ../../username.nix;
  cfg = config.modules.dev;
in {
  imports = [
    ./options.nix
  ];
  config = mkMerge [
    (
      mkIf (cfg.enable) {
        environment.systemPackages = with pkgs; [
          git-ignore
        ];
        home-manager.users.${username} = {...}: {
          imports = [
            ./git.nix
          ];
        };
      }
    )
  ];
}
