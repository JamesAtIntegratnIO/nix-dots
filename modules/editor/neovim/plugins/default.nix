{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  imports = [
    ./comment-nvim.nix
    ./coq.nix
    ./startify.nix
    ./lsp.nix
    ./conform-nvim.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  config = mkIf cfg.neovim {
    programs.nixvim.plugins = {
      gitgutter.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      barbar.enable = true;
    };
  };
}
