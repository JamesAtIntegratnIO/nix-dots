{base-options, ...}: {
  system = "x86_64-linux";
  modules =
    base-options.modules
    ++ [
      ./features.nix
    ];

  inherit (base-options) specialArgs;
}
