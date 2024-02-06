{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  username = import ../../username.nix;
  cfg = config.modules.virtualisation;
in {
  config = mkIf (builtins.elem "libvirtd" cfg.vmVariant) {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    users.users.${username}.extraGroups = ["libvirtd"];

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      virt-viewer
      virtio-win
      win-spice
    ];
    programs.virt-manager.enable = true;

    home-manager.users.${username} = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
}
