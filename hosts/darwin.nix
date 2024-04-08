{ 
  inputs,
  self,
}: let
  inherit (inputs) home-manager nixpkgs nixos-generators;

  systemNames = ["work"];

  base-options = {
    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      ../work-user.nix
      ../nixos.nix
    ];
  };

  mkSystem = sysName: nixpkgs.lib.nixosSystem ((import ./${sysName}) {inherit base-options;});
  
  systems = map (sysName: {${sysName} = mkSystem sysName;}) systemNames;
 
  mergedSystems = nixpkgs.lib.foldr (coming: final: final // coming) {} (systems);
in
  mergedSystems
