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
    nixd = {
      enable = true;
    };
  };
}
