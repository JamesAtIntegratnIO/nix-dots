{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins.conform-nvim = {
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
  };
}
