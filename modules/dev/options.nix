{lib, ...}:
with lib; {
  options.modules.dev = {
    enable = mkEnableOption "dev";
    langs = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["golang" "python" "rust"];
      description = ''
        List of languages to enable dev tools for.
      '';
    };
    devops = {
      tools = mkOption {
        type = types.listOf types.str;
        default = [];
        example = ["kubernetes" "terraform" "aws" "gcp"];
        description = ''
          List of devops tools to enable.
        '';
      };
    };
  };
}
