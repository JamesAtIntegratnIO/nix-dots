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
    theme = {
      name = mkOption {
        type = types.enum ["frappe" "latte" "macchiato" "mocha"];
        default = "macchiato";
        description = ''
          The theme to use.
        '';
      };
      style = mkOption {
        type = types.enum [null "adwaita" "adwaita-dark" "adwaita-highcontrast" "adwaita-highcontrastinverse" "bb10bright" "bb10dark" "breeze" "cde" "cleanlooks" "gtk2" "kvantum" "motif" "plastique"];
        default = "adwaita-dark";
        description = ''
          The style to use.
        '';
      };
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
