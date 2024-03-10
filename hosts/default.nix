{
  inputs,
  self,
  ...
}: let
  inherit (inputs) home-manager nixpkgs nixos-generators;

  systemNames = [
    "lappy"
    "gamer"
    "k8s-master"
    "k8s-worker1"
    "k8s-worker2"
  ];

  base-options = {
    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      ../nixos.nix
      ../user.nix
    ];
  };

  live-options = {
    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      ../nixos.nix
      ../user.nix
      ../live.nix
    ];
  };

  proxmox-options = {
    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      ../nixos.nix
      ../user.nix
      ../proxmox.nix
    ];
  };

  mkSystem = sysName: nixpkgs.lib.nixosSystem ((import ./${sysName}) {inherit base-options;});
  mkLiveSystem = sysName: nixpkgs.lib.nixosSystem ((import ./${sysName}) {base-options = live-options;});
  mkProxmoxSystem = sysName: nixpkgs.lib.nixosSystem ((import ./${sysName}) {base-options = proxmox-options;});

  systems = map (sysName: {${sysName} = mkSystem sysName;}) systemNames;
  liveSystems = map (sysName: {"${sysName}-live" = mkLiveSystem sysName;}) systemNames;
  proxmoxSystems = map (sysName: {"${sysName}-proxmox" = mkProxmoxSystem sysName;}) systemNames;

  mergedSystems = nixpkgs.lib.foldr (coming: final: final // coming) {} (systems ++ liveSystems ++ proxmoxSystems);
in
  mergedSystems
