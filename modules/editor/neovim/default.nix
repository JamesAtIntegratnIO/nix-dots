{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
  username = import ../../../username.nix;
  vimLsp = import ./lsp.nix;
in {
  imports = [
    ./plugins/startify.nix
    ./keymaps.nix
    ./plugins/lsp.nix
    ./plugins/conform-nvim.nix
    ./plugins/nvim-tree.nix
    ./plugins/telescope.nix
  ];
  config = mkMerge [
    (mkIf cfg.neovim {
      programs.nixvim = {
        enable = true;
        extraPackages = with pkgs; [
          alejandra
          stylua
          rustc
          go
          ripgrep
          fd
          zig
          shfmt
        ];

        colorschemes.catppuccin = {
          enable = true;
          flavour = "macchiato";
          dimInactive = {
            enabled = true;
            percentage = 0.15;
          };
        };

        options = {
          number = true;
          shiftwidth = 2;
          tabstop = 2;
        };

        globals.mapleader = ",";

        plugins = {
          gitgutter.enable = true;
          treesitter.enable = true;
          nvim-autopairs.enable = true;
          which-key.enable = true;
          barbar.enable = true;
        };
      };
    })
  ];
}
