{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins.nvim-tree = {
      enable = true;
      git = {
        enable = true;
      };
      modified = {
        enable = true;
      };
      autoClose = true;
    };
  };
}
