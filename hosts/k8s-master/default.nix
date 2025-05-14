{base-options, ...}: {
  system = "aarch64-linux";
  modules =
    base-options.modules
    ++ [
      ./features.nix
    ];

  inherit (base-options) specialArgs;
}
