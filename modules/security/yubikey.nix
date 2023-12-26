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
        pam.services = {
          login.u2fAuth = true;
          sudo.u2fAuth = true;
        };
        rtkit.enable = true;
      };
      services = {
        udev.packages = [pkgs.yubikey-personalization];
        pcscd.enable = true;
      };
    })
  ];
}
