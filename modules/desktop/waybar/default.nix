{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
  username = import ../../../username.nix;
  light = "${pkgs.light}/bin/light";
  pactl = "${pkgs.pulseaudioFull}/bin/pactl";
  conf = {
    layer = "top";
    modules-left = ["hyprland/workspaces" "hyprland/mode"];
    modules-right = [
      "pulseaudio"
      "backlight"
      "idle_inhibitor"

      "clock"
      "tray"

      "bluetooth"
      "network"

      "cpu"
      "memory"
      "battery"
      "temperature"
    ];
    modules-center = [];
    "hyprland/mode" = {format = ''<span style="italic">{}</span>'';};
    "hyprland/workspaces" = {
      all-outputs = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "5" = "";
        urgent = "";
        active = "";
        default = "";
      };
      sort-by-number = true;
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    tray = {
      icon-size = 21;
      spacing = 5;
    };
    clock = {
      tooltip-format = "{:%Y-%m-%d | %H:%M}";
      format = "{:%F %T %Z}";
    };
    cpu = {
      format = "{usage}% ";
      tooltip = false;
    };
    memory = {format = "{}% ";};
    temperature = {
      hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = ["" "" ""];
    };
    backlight = {
      format = "{percent}% {icon}";
      format-icons = ["" ""];
      on-scroll-up = "${light} -A 1";
      on-scroll-down = "${light} -U 1";
    };
    battery = {
      states = {
        good = 90;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      format-icons = ["" "" "" "" ""];
    };
    bluetooth = {
      format = " {status}";
      format-connected = " {device_alias}";
      format-connected-abattery = " {device_alias} {device_battery_percentage}%";
      tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
      on-click = "sleep 0.1 && /usr/bin/env rofi-bluetooth --theme ~/.config/rofi/config/bluetooth.rasi";
    };
    network = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      on-click = "sleep 0.1 && /usr/bin/env rofi-wifi-menu --theme ~/.config/rofi/config/networkmenu.rasi";
    };
    pulseaudio = {
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphones = "";
        handsfree = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "sleep 0.1 && ~/.config/waybar/scripts/audio-switch.sh speaker";
      on-click-right = "sleep 0.1 && ~/.config/waybar/scripts/audio-switch.sh mic";
      on-scroll-up = "${pactl} set-sink-volume @DEFAULT_SINK@ +1%";
      on-scroll-down = "${pactl} set-sink-volume @DEFAULT_SINK@ -1%";
    };
  };
in {
  config = mkIf ((cfg.desktop == "hyprland") && (cfg.panel == "waybar")) {
    environment.systemPackages = with pkgs; [
      waybar
      python3
    ];
    home-manager.users.${username} = {...}: {
      xdg.configFile = {
        waybar = {
          target = "waybar/config";
          text = builtins.toJSON conf;
        };
        audio-switch = {
          target = "waybar/scripts/audio-switch.sh";
          source = ./audio-switch.sh;
        };
      };
    };
  };
}
