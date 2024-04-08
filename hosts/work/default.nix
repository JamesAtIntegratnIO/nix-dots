{base-options, ...}: {
  system = "aarch64-darwin";
  modules = 
  base-options.modules
  ++ [
    ./features.nix
  ];

  inherit (base-options) specialArgs;
}