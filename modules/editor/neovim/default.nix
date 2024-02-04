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
  vimKeymaps = import ./keymaps.nix;
  vimLsp = import ./lsp.nix;
  vimStartup = import ./startup.nix;
in {
  config = mkMerge [
    (mkIf cfg.neovim {
      programs.nixvim = {
        enable = true;
        colorschemes.catppuccin = {
          enable = true;
          flavour = "macchiato";
          dimInactive = {
            enable = true;
            percentage = 0.15;
          };
        };
        options = {
          number = true;
          shiftwidth = 2;
        };
        globals.mapleader = ",";
        keymaps = vimKeymaps;
        plugins = {
          lsp = vimLsp;
          telescope = {
            enable = true;
            keymaps = {
              "<leader>fg" = "live_grep";
              "<C-p>" = {
                action = "git_files";
                desc = "Telescope Git Files";
              };
            };
          };
          treesitter = {
            enable = true;
          };

          copilot-lua = {
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
          nvim-tree = {
            enable = true;
            git = {
              enable = true;
            };
            modified = {
              enable = true;
            };
          };
          startup = vimStartup;
        };
      };
      environment.systemPackages = with pkgs; [
        ripgrep
        fd
        zig
      ];
    })
  ];
}
