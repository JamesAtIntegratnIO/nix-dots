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
  config = mkMerge [
    (mkIf (cfg.type == "intel") {
      hardware.opengl = {
        enable = true;
        driSupport32Bit = true;
        driSupport = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
      environment.systemPackages = with pkgs; [
        sof-firmware
      ];
    })
    (mkIf (cfg.type == "nvidia") {
      environment.systemPackages = with pkgs; [
        # linuxPackages.nvidia_x11
        libGL
        libGLU
        libsForQt5.qtwayland
        libva
        nvtop-nvidia
      ];
      boot = {
        blacklistedKernelModules = ["nouveau"];
        kernelModules = [
          "nvidia"
        ];
        kernelParams = [
          "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
          "nvidia-drm.modeset=1"
        ];
      };
      services.xserver.videoDrivers = ["nvidia"];
      hardware = {
        opengl = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = with pkgs; [
            nvidia-vaapi-driver
            vaapiVdpau
            libvdpau-va-gl
          ];
        };
        nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.beta;
          open = false;
          modesetting.enable = true;
          nvidiaSettings = true;
          powerManagement.enable = true;
        };
      };
    })
  ];
}
