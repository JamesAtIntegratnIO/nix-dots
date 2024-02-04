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
in {
  imports = [
    ./keymaps.nix
		./plugins
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
          nixd
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
      };
    })
  ];
}
