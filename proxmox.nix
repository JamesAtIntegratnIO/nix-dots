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
        cores = 4;
        memory = 4096;
        diskSize = "24096";
        agent = true;
        bios = "seabios";
      };
    }
  ];
  # fileSystems."/".device = mkForce "/dev/disk/by-label/nixos";

  boot.loader.systemd-boot.enable = mkForce false;

  services = {
    cloud-init.network.enable = true;
    openssh.enable = true;
    qemuGuest.enable = true;
  };
}
