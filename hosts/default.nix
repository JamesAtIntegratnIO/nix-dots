{
  inputs,
  self,
  ...
}: let
  inherit (inputs) home-manager nixpkgs;

  systemNames = ["lappy"];

  base-options = {
    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      ../nixos.nix
      ../user.nix
    ];
  };

  mkSystem = sysName: nixpkgs.lib.nixosSystem ((import ./${sysName}) {inherit base-options;});

  systems = map (sysName: {${sysName} = mkSystem sysName;}) systemNames;

  mergedSystems = nixpkgs.lib.foldr (a: b: b // a) {} systems;
in
  mergedSystems
