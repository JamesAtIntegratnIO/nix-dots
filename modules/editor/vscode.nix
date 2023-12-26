{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor;
  username = import ../../username.nix;
  inherit (config.modules) graphics;
in {
  config = mkIf (cfg.vscode && (graphics.type != null)) {
    users.users.${username} = {
      packages = with pkgs; [
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions;
            [
              golang.go
              github.copilot
              mhutchie.git-graph
              eamodio.gitlens
              viktorqvarfordt.vscode-pitch-black-theme
              ms-python.python
              matklad.rust-analyzer
              bbenoist.nix
              arrterian.nix-env-selector
              ms-kubernetes-tools.vscode-kubernetes-tools
              ms-azuretools.vscode-docker
              timonwong.shellcheck
              tamasfe.even-better-toml
              ms-vscode-remote.remote-ssh
              redhat.vscode-yaml
              hashicorp.terraform

              # Extensions for my KB
              foam.foam-vscode
              yzhang.markdown-all-in-one
              bierner.emojisense
              bierner.markdown-mermaid
              tomoki1207.pdf
              gruntfuggly.todo-tree
              esbenp.prettier-vscode
            ]
            ++ vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "alejandra";
                publisher = "kamadorueda";
                version = "1.0.0";
                sha256 = "08e9448ca866f2d2b95df3a3ae95540d0ef1dc968e2e262867831dc132fc92d9";
              }
              {
                name = "nunjucks";
                publisher = "ronnidc";
                version = "0.3.1";
                sha256 = "sha256-7YfmRMhC+HFmYgYtyHWrzSi7PZS3tdDHly9S1kDMmjY=";
              }
            ];
        })
      ];
    };
  };
}
