{
  config,
  pkgs,
  self,
  inputs,
  ...
}: let
  username = import ./username.nix;
in {
  environment = {
    systemPackages = with pkgs; [
      inputs.agenix.packages.${system}.default
      usbutils
      pciutils
    ];
  };
  nixpkgs.config = {
    allowUnfree = true;
  };

  time.timeZone = "America/Denver";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        username
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };
  home-manager.users.${username} = {
    nixpkgs.config = {
      allowUnfree = true;
    };

    home.stateVersion = "22.11";
  };

  system = {
    stateVersion = "24.05"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      flake = "${inputs.self.outPath} #${config.modules.network.hostName}";
      flags = [
        "--update-input"
        "nixpkgs"
        "-L"
      ];
      allowReboot = true;
      operation = "switch";
      rebootWindow = {
        lower = "01:00";
        upper = "04:00";
      };
    };
  };
}
