{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
  username = import ../../../../username.nix;
  css = ''
        * {
      font-family: FantasqueSansMono Nerd Font;
      font-size: 17px;
      min-height: 0;
    }

    #waybar {
      background: transparent;
      background-color: @base;
      opacity: 0.9;
      color: @text;
      margin: 5px 5px;
    }

    #workspaces {
      border-radius: 1rem;
      margin: 5px;
      background-color: @surface0;
      margin-left: 1rem;
    }

    #workspaces button {
      color: @lavender;
      border-radius: 1rem;
      padding: 0.4rem;
    }

    #workspaces button.active {
      color: @sky;
      border-radius: 1rem;
    }

    #workspaces button:hover {
      color: @sapphire;
      border-radius: 1rem;
    }

    #custom-music,
    #idle_inhibitor,
    #tray,
    #backlight,
    #clock,
    #battery,
    #pulseaudio,
    #custom-lock,
    #cpu,
    #memory,
    #temperature,
    #bluetooth,
    #network,
    #custom-power {
      background-color: @surface0;
      padding: 0.5rem 1rem;
      margin: 5px 0;
    }

    #bluetooth {
      color: @blue;
      border-radius: 1rem 0px 0px 1rem;
      margin-left: 1rem;
    }

    #network {
      color: @lavender;
      margin-right: 1rem;
      border-radius: 0px 1rem 1rem 0px;
    }

    #clock {
      color: @blue;
      border-radius: 0px 1rem 1rem 0px;
      margin-right: 1rem;
    }

    #battery {
      color: @green;
    }

    #battery.charging {
      color: @green;
    }

    #battery.warning:not(.charging) {
      color: @red;
    }

    #backlight {
      color: @yellow;
    }

    #idle_inhibitor {
      color: @peach;
    }

    #backlight, #battery {
      border-radius: 0;
    }

    #pulseaudio {
      color: @maroon;
      border-radius: 1rem 0px 0px 1rem;
      margin-left: 1rem;
    }

    #custom-music {
      color: @mauve;
      border-radius: 1rem;
    }

    #custom-lock {
      border-radius: 1rem 0px 0px 1rem;
      color: @lavender;
    }

    #custom-power {
      margin-right: 1rem;
      border-radius: 0px 1rem 1rem 0px;
      color: @red;
    }

    #tray {
      margin-right: 1rem;
      border-radius: 1rem;
    }

    #cpu {
      margin-left: 1rem;
      border-radius: 1rem 0px 0px 1rem;
      color: @teal;
    }

    #memory {
      color: @blue;
    }

    #temperature {
      margin-right: 1rem;
      border-radius: 0px 1rem 1rem 0px;
      color: @green;
    }

    #temprature.critical {
      color: @red;
      margin-right: 1rem;
      border-radius: 0px 1rem 1rem 0px;
    }
  '';
in {
  config = mkIf ((cfg.desktop == "hyprland")
    && (cfg.panel == "waybar")) {
    home-manager.users.${username}.xdg.configFile = {
      frappe-css = {
        target = "waybar/frappe.css";
        source = ./css/frappe.css;
      };
      latte-css = {
        target = "waybar/latte.css";
        source = ./css/latte.css;
      };
      macchiato-css = {
        target = "waybar/macchiato.css";
        source = ./css/macchiato.css;
      };
      mocha-css = {
        target = "waybar/mocha.css";
        source = ./css/mocha.css;
      };
      waybar-style = {
        target = "waybar/style.css";
        text = strings.concatStrings [
          ''
            @import "${cfg.theme.name}.css";
          ''
          css
        ];
      };
    };
  };
}
