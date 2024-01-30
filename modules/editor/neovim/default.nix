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
  config = mkMerge [
    (mkIf cfg.neovim {
      programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        options = {
          number = true;
          shiftwidth = 2;
        };
	globals.mapleader = ",";
	keymaps = [
	  {
	    key = "<leader>ft";
	    action = "<cmd>NvimTreeToggle<CR>";
	  }
	  {
	    key = "<leader>ff";
	    action = "<cmd>Telescope find_files<CR>";
	  }
	  {
	    key = "<leader>fb";
	    action = "<cmd>Telescope buffers<CR>";
	  }
	  {
	    key = "<leader>fg";
	    action = "<cmd>Telescope live_grep<CR>";
	  }
	  {
	    key = "<leader>fp";
	    action = "<cmd>Telescope git_files<CR>";
	  }
       	    
	];
        plugins = {
          lsp = {
            enable = true;
            enabledServers = [
              "ansiblels"
              "bashls"
              "dockerls"
              "gopls"
              "hls"
              "html"
              "htmx"
              "jsonls"
              "lemminx"
              "lua-ls"
              "marskman"
              "nixd"
              "pylsp"
              "rust-analyzer"
              "terraformls"
              "tsserver"
              "vuels"
              "yamlls"
              "zls"
            ];
            servers ={
	      rust-analyzer = {
		enable = true;
		installCargo = true;
		installRustc = true;
	      };
	      lua-ls = {
		enable = true;
		settings.telemetry.enable = false;
	      };
	      marksman = {
		enable = true;
	      };
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
	    
          };
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
