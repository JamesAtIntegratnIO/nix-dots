{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins = {
      comment-nvim = {
        enable = true;
      };
      ts-context-commentstring.enable = true;
    };
  };
}
