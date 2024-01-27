{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.graphics;
  username = import ../../username.nix;
in {
  imports = [
    ./options.nix
  ];
  config = mkIf (cfg.type == "nvidia") {
    environment.systemPackages = with pkgs; [
      linuxPackages.nvidia_x11
      libGL
      libGLU
      libsForQt5.qtwayland
      libva
    ];
    boot = {
      blacklistedKernelModules = ["nouveau"];
      kernelModules = [
        "nvidia"
      ];
      kernelParams = [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];
    };
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement.enable = true;
      };
    };
  };
}
