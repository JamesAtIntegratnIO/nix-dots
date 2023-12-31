{
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
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4192;
      cores = 4;
    };
    virtualisation.qemu.options = [
      "-vga none"
      "-device virtio-vga-gl"
      "-display gtk,gl=on,show-cursor=off"
      "-audio pa,model=hda"
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
