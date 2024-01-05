{
  lib,
  config,
  modulesPath,
  inputs,
  ...
}:
with lib; {
  imports = [
    "${modulesPath}/virtualisation/proxmox-image.nix"
    {
      proxmox.qemuConf = {
        name = config.modules.network.hostName;
        virtio0 = "local-zfs";
        bios = "ovmf";
        cores = 4;
        memory = 4096;
        diskSize = "24096";
      };
    }
  ];

  fileSystems."/".device = mkForce "/dev/disk/by-label/nixos";
  fileSystems."/boot".device = mkForce "/dev/disk/by-label/ESP";
  # boot.loader.systemd-boot.enable = mkForce false;
}
