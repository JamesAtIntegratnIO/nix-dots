{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.terminal;
  username = import ../../../username.nix;
in {
  config = mkIf cfg.tmux {
    home-manager.users.${username} = {
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        prefix = "C-Space";

        plugins = with pkgs.tmuxPlugins; [
          better-mouse-mode
          sensible
          vim-tmux-navigator
          {
            plugin = catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavour 'macchiato'
              set -g @catppuccin_window_left_separator "█"
              set -g @catppuccin_window_right_separator "█ "
              set -g @catppuccin_window_number_position "right"
              set -g @catppuccin_window_middle_separator "  █"

              set -g @catppuccin_window_default_fill "number"

              set -g @catppuccin_window_current_fill "number"
              set -g @catppuccin_window_current_text "#{pane_current_path}"

              set -g @catppuccin_status_modules_right "application session date_time"
              set -g @catppuccin_status_left_separator  ""
              set -g @catppuccin_status_right_separator " "
              set -g @catppuccin_status_right_separator_inverse "yes"
              set -g @catppuccin_status_fill "all"
              set -g @catppuccin_status_connect_separator "no"
            '';
          }
          {
            plugin = resurrect;
            extraConfig = "set -g @resurrect-strategy-nvim 'session'";
          }
        ];

        extraConfig = ''
          set -g mouse on

          # quickly open a new window
          bind N new-window

          # synchronize all panes in a window
          bind y setw synchronize-panes

          # pane movement shortcuts (same as vim)
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R




        '';
      };
    };
  };
}
