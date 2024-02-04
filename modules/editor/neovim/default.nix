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
        extraPackages = with pkgs; [
          alejandra
          stylua
          rust-analyzer
          rustc
          go
          ripgrep
          fd
          zig
          marksman
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
        };
        globals.mapleader = ",";
        keymaps = vimKeymaps;
        plugins = {
          gitgutter = {
            enable = true;
            recommendedSettings = true;
          };
          lsp = vimLsp;
          conform-nvim = {
            enable = true;
            formattersByFt = {
              nix = ["alejandra"];
              lua = ["stylua"];
              javascript = ["prettierd"];
              terraform = ["terraform_fmt"];
              python = ["black"];
              go = ["gofmt"];
              rust = ["rustfmt"];
              json = ["prettierd"];
              yaml = ["prettierd"];
              sh = ["shfmt"];
            };
            formatOnSave = {
              lspFallback = true;
              timeoutMs = 500;
            };
          };

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
            autoClose = true;
          };
          startup = vimStartup;
          nvim-autopairs = {
            enable = true;
          };
          which-key = {
            enable = true;
          };
        };
      };
    })
  ];
}
