{lib, ...}:
with lib; {
  options.modules.terminal = {
    shells = mkOption {
      type = types.listOf types.str;
      default = ["zsh"];
      description = "The shells to install in the terminal";
      example = ["zsh" "bash" "fish"];
    };
    defaultShell = mkOption {
      type = types.str;
      default = "zsh";
      description = "The default shell to use";
      example = "zsh";
    };
  };
}
