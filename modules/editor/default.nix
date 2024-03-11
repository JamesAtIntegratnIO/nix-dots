{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
  username = import ../../username.nix;
in {
  imports = [
    ./neovim
    ./vscode.nix
    ./vim.nix
    ./options.nix
  ];

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      alejandra
    ];
  };
}
