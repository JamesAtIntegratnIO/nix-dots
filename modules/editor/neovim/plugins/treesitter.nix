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
      treesitter = {
        enable = true;
        nixGrammars = true;
        ensureInstalled = "all";
        indent = true;
        folding = false;
      };
      rainbow-delimiters.enable = true;
      treesitter-context = {
        enable = true;
        mode = "topline";
      };
      ts-autotag.enable = true;
    };
  };
}
