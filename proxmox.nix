# This will likely conflict very heavily with your hardware-configuration.nix. Specifically, around the filesystems, boot.loader, and bios.
# Unless your proxmox is setup to work well with systemd you won't be able to boot with a systemd filesystem or bootloader.
# The easiest way I've found to override this behavior is to let proxmox-image.nix own these parts of the configuration and use mkMerge with mkIf
# in the hardware-configuration.nix to conditionally create the filesystems and boot loader based on if the services.qemuGuest.enable is true.
# This is hacky as shit. Feel free to show me how to do it better.
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

  boot.loader.systemd-boot.enable = mkForce false;

  services = {
    cloud-init.network.enable = true;
    openssh.enable = true;
    qemuGuest.enable = true;
  };
}
