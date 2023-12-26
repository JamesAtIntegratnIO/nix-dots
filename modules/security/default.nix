{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.security;
in {
  imports = [
    ./yubikey.nix
  ];

  config = mkMerge [
    {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    }
  ];
}
