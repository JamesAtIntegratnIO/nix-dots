{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  username = import ../../../username.nix;
  cfg = config.modules.desktop;
  inherit (config.modules) graphics;
in {
  config = mkMerge [
    (
      mkIf (cfg.desktop == "hyprland") {
        home-manager.users.${username} = {
          wayland.windowManager.hyprland.settings = mkMerge [
            {
              source = "~/.config/hypr/colors.conf";
              # Set programs that you use
              # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
              "$terminal" = "kitty";
              "$fileManager" = "dolphin";
              "$browser" = "firefox";
              "$menu" = "bash /home/${username}/.config/rofi/bin/launcher.sh";
              "$mainMod" = "SUPER";

              "$lockCommand" = "gtklock -T 60 -H -i";

              env = [
                "XCURSOR_SIZE,24"
                "QT_QPA_PLATFORMTHEME,qt5ct" # change to qt6ct if you have that
              ];
              # Monitor config
              monitor = [
                "DP-3,highrr,auto,auto"
                "eDP-1,1920x1200,3840x0,1"
                # Monitor got renamed for some rando reason
                # so there are 2 matching entries here
                # The way wayland does this is dumb
                "DP-6,3840x2160,0x0,1"
                "DP-7,3840x2160,0x0,1"

                "DP-2,1920x1080,3840x1200,1"
              ];
              # monitor = [",preferred,auto,auto"];

              bindl = [
                # lid is opened
                ",switch:off:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, 1920x1200,3840x0,1'"
                # lid is closed
                ",switch:on:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'"
              ];
              exec-once = [
                "dunst"
                # IDLE HANDLER
                # ''
                #   swayidle -w timeout 300 "$lockCommand" \
                #               timeout 600 "hyprctl dispatch dpms off" \
                #               resume "hyprctl dispatch dpms on"
                # ''
                "/usr/bin/env hyprland-monitor-attached /run/current-system/sw/bin/rokid-attached /run/current-system/sw/bin/rokid-detached"
              ];
              input = {
                kb_layout = "us";
                follow_mouse = 1;

                touchpad = {
                  natural_scroll = false;
                };

                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
              };
              general = {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
                "col.active_border" = "$teal 45deg";
                "col.inactive_border" = "$surface1";

                layout = "dwindle";

                # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
                allow_tearing = false;
              };
              decoration = {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                rounding = 10;

                blur = {
                  enabled = true;
                  size = 3;
                  passes = 1;

                  vibrancy = 0.1696;
                };

                drop_shadow = true;
                shadow_range = 4;
                shadow_render_power = 3;
                "col.shadow" = "$teal";
                "col.shadow_inactive" = "$surface1";
              };

              animations = {
                enabled = true;

                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

                animation = [
                  "windows, 1, 7, myBezier"
                  "windowsOut, 1, 7, default, popin 80%"
                  "border, 1, 10, default"
                  "borderangle, 1, 8, default"
                  "fade, 1, 7, default"
                  "workspaces, 1, 6, default"
                ];
              };

              dwindle = {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true; # you probably want this
              };

              master = {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true;
              };

              gestures = {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = true;
              };

              misc = {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
              };
              # Example windowrule v1
              # windowrule = float, ^(kitty)$
              # Example windowrule v2
              # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
              # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
              # windowrulev2 = "nomaximizerequest, class:.* # You'll probably like this.";

              # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
              bind = [
                "$mainMod, Q, exec, $terminal"
                "$mainMod, W, exec, $browser"
                "$mainMod, K, killactive"
                "$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, R, exec, $menu"
                "$mainMod, P, pseudo, # dwindle"
                "$mainMod, J, togglesplit, # dwindle"
                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"
                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"
                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"
                # Example special workspace (scratchpad)
                # "$mainMod, S, togglespecialworkspace, magic"
                # "$mainMod SHIFT, S, movetoworkspace, special:magic"
                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
                # Screenshot Area
                "$mainMod, S, exec, bash /home/${username}/.config/rofi/bin/screenshot.sh"
                "$mainMod SHIFT, S, exec, grimblast copy area"
                # Lockscreen
                "$mainMod SHIFT, L, exec, $lockCommand"
                # Rofi
                "$mainMod SHIFT, P, exec, bash /home/${username}/.config/rofi/bin/powermenu.sh"
                "$mainMod SHIFT, B, exec, rofi-bluetooth"
                # Mute
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              ];
              bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
              ];

              binde = [
                # Volume
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
                "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%+"
                "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%-"
                # Brightness
                ", xf86monbrightnessup, exec, brightnessctl set 10%+"
                ", xf86monbrightnessdown, exec, brightnessctl set 10%-"
              ];
            }
            (mkIf (cfg.panel == "waybar") {
              exec-once = [
                "waybar"
              ];
            })
            (mkIf (cfg.panel == "nwg-panel") {
              exec = [
                "nwg-panel"
              ];
            })
          ];
        };
      }
    )
  ];
}
