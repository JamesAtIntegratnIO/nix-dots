{
  lib,
  config,
  inputs,
  ...
}: {
  # TODO: Use mkForce to override settings that are not needed in live envs

  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberry-pi.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi-installer.nix"
  ];

  sdImage = {
    volumeID = lib.mkForce "${config.networking.hostName}-sd-image";
    imageName = lib.mkForce "${config.networking.hostName}-nixos.img";
    squashfsCompression = "gzip -Xcompression-level 1";
  };
}
