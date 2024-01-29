{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
  username = import ../../../username.nix;
  inherit (config.modules) graphics;
in {
  config = mkIf (cfg.lunarvim) {
    # install lunarvim
    environment.systemPackages = with pkgs; [
      pkgs.lunarvim
    ];
    home-manager.users.${username} = {...}: {
      # create a file at ~/.config/lvim/config.lua using generators.toLua{}
      xdg.configFile = {
        lunarvim-test = {
          target = "lvim/config.lua";
          source = ./config.lua;
        };
      };
    };
  };
}
