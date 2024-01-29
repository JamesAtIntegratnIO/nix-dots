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
  inherit (config.modules) graphics;
in {
  config = mkIf (cfg.lunarvim) {
    # install lunarvim
    environment.systemPackages = with pkgs; [
      pkgs.lunarvim
    ];
    # create a file at ~/.config/lvim/config.lua
  };
}
