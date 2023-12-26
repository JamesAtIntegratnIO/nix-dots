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
    (mkIf (cfg.enable && (builtins.elem "golang" cfg.langs)) {
      users.users.${username} = {
        packages = with pkgs; [
          go
          gopls
          go-outline
          golangci-lint
          gocode
        ];
      };
    })
  ];
}
