{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins.copilot-lua = {
      enable = true;
      panel = {
        enabled = true;
        autoRefresh = true;
        layout = {
          position = "bottom";
          ratio = 0.4;
        };
      };
      suggestion = {
        enabled = true;
        autoTrigger = true;
      };
    };
  };
}
