{base-options, ...}: {
  system = "x86_64-linux";
  modules =
    base-options.modules
    ++ [
      ./hardware-configuration.nix
      ./features.nix
      # TODO: Figure out how to make this work
      # nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
    ];

  inherit (base-options) specialArgs;
}
