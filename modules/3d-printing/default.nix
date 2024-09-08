{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.threedPrinting;
in {
  imports = [
    ./options.nix
  ];

  config = mkMerge [
    (mkIf (cfg.orca-slicer) {
      environment.systemPackages = with pkgs; [
        orca-slicer
      ];
    })
  ];
}