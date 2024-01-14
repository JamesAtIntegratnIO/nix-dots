{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.security;
in {
  imports = [./options.nix];
  config = mkMerge [
    {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    }
    (mkIf cfg.yubikey.enable {
      security = {
        pam = {
          services = {
            login.u2fAuth = true;
            sudo.u2fAuth = true;
          };
          yubico = {
            enable = true;
            debug = false;
            mode = "challenge-response";
            id = ["16411128"];
          };
        };
        rtkit.enable = true;
      };
      services = {
        udev.packages = [pkgs.yubikey-personalization];
        pcscd.enable = true;
      };
      environment.systemPackages = with pkgs; [
        # Tools required
        wget
        # Tools for backing up keys
        paperkey
        pgpdump
        parted
        cryptsetup

        # Yubico's official tools
        yubikey-manager
        yubikey-manager-qt
        yubikey-personalization
        yubikey-personalization-gui
        yubico-piv-tool
        yubioath-flutter

        # Testing
        ent

        # Password generation tools
        diceware
        pwgen

        # Miscellaneous tools that might be useful beyond the scope of the guide
        cfssl
        pcsctools

        # For pinentry
        pinentry
        pinentry-rofi
      ];
    })
  ];
}
