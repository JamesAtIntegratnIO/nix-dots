{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins = {
      coq-nvim = {
        enable = true;
        autoStart = true;
        recommendedKeymaps = true;
        alwaysComplete = true;
      };
    };
  };
}
