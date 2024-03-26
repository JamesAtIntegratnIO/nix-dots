{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.3dPrinting;
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
  ]
}