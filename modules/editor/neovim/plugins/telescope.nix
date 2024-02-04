{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>fg" = "live_grep";
        "<C-p>" = {
          action = "git_files";
          desc = "Telescope Git Files";
        };
      };
    };
  };
}
