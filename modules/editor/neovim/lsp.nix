{
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
  servers = {
    rust-analyzer = {
      installCargo = true;
      installRustc = true;
    };
    lua-ls = {
      settings.telemetry.enable = false;
    };
  };
}
