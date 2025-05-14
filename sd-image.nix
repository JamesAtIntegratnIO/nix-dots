{
  lib,
  config,
  inputs,
  ...
}: {
  # TODO: Use mkForce to override settings that are not needed in live envs

  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi-installer.nix"
  ];

  sdImage = {
  };
}
