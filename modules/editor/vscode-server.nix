{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
  user = import ../../username.nix;
in {
  config = mkMerge [
    (mkIf cfg.vscode-server {
      inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";

      modules = [
        vscode-server.nixosModules.default
      ];
      services.vscode-server.enable = true;
    })
  ];
}
