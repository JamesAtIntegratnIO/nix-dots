{lib, ...}:
with lib; {
  options.modules.displayManager = {
    greeter = mkOption {
      type = types.enum ["sddm" "tuigreet" null];
      default = null;
      description = "The greeter to use.";
    };
    defaultSession = mkOption {
      type = types.enum ["Hyprland" null];
      default = null;
      description = "The default session to use.";
    };
  };
}
