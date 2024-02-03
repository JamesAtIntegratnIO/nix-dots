{lib, ...}:
with lib; {
  options.modules.desktop = {
    desktop = mkOption {
      type = types.enum ["hyprland" null];
      default = null;
      description = ''
        The desktop environment to use.
      '';
    };
    panel = mkOption {
      type = types.enum ["waybar" "nwg-panel" null];
      default = null;
      description = ''
        The panel to use.
      '';
      example = "waybar";
    };
    theme = mkOption {
      type = types.enum ["frappe" "latte" "macchiato" "mocha"];
      default = "macchiato";
      description = ''
        The theme to use.
      '';
    };

    screenWidth = mkOption {
      type = types.int;
      default = 1920;
      description = ''
        The width of the screen in pixels.
      '';
    };

    screenHeight = mkOption {
      type = types.int;
      default = 1080;
      description = ''
        The height of the screen in pixels.
      '';
    };

    screenRefreshRate = mkOption {
      type = types.int;
      default = 60;
      description = ''
        The refresh rate of the screen in Hz.
      '';
    };

    screenScalingRatio = mkOption {
      type = types.int;
      default = 1;
      description = ''
        The scaling ratio of the screen.
      '';
    };
  };
}
