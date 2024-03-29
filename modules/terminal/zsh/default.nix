{
  config,
  pkgs,
  lib,
  inputs,
  #   homeDirectory,
  ...
}:
with lib; let
  cfg = config.modules.terminal;
  username = import ../../../username.nix;
in {
  config = mkIf (builtins.elem "zsh" cfg.shells) {
    home-manager.users.${username} = {...}: {
      programs.zsh = with pkgs; {
        enable = true;
        oh-my-zsh.enable = true;
        plugins = import ./plugins.nix {inherit pkgs;};
        zplug = {
          enable = true;
          plugins = [
            {
              name = "plugins/kubectl, from:oh-my-zsh";
            }
          ];
        };
        localVariables = {};
        dotDir = ".config/zsh";
        dirHashes = {
          docs = "$HOME/Documents";
          downloads = "$HOME/Downloads";
          projects = "$HOME/Projects";
          dots = "$HOME/Projects/nix-dots";
        };
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        history = {
          size = 50000;
          save = 10000;
          ignorePatterns = ["rm *" "pkill *"];
          expireDuplicatesFirst = true;
          extended = true;
        };
        sessionVariables = {
          GPG_TTY = "$(tty)";
          SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
          #   XDG_DATA_DIRS = "${homeDirectory}/.nix-profile/share/:${homeDirectory}/.local/share/:/usr/share/:/usr/local/share/:$XDG_DATA_DIRS";
          # For Alacritty : See https://github.com/alacritty/alacritty/issues/1501
          WINIT_X11_SCALE_FACTOR = "1.0";
        };
        initExtraFirst = ''
        '';
        initExtra = ''
          autoload -Uz compinit
          gpgconf --launch gpg-agent
          compinit
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
          zstyle ':completion:*' rehash true                              # automatically find new executables in path
          zstyle ':completion:*' completer _expand _complete _ignored _approximate
          zstyle ':completion:*' menu select
          zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
          zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

          zstyle ':completion:*' accept-exact '*(N)'
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path ~/.cache/zcache

          autoload -U +X bashcompinit && bashcompinit

          neofetch
        '';
        shellAliases = import ./aliases.nix;
      };
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
