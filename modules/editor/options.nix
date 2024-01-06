{lib, ...}:
with lib; {
  options.modules.editor = {
    enable = mkEnableOption "editor";
    vscode = mkEnableOption "vscode";
  };
}
