{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.plugins = {
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
          "lua_ls"
          "marksman"
          "nixd"
          "pylsp"
          "rust_analyzer"
          "terraformls"
          "tsserver"
          "vuels"
          "yamlls"
          "zls"
        ];
        servers = {
          rust-analyzer = {
            installCargo = true;
            installRustc = true;
          };
          lua-ls = {
            settings.telemetry.enable = false;
          };
        };
      };
    };
  };
}
