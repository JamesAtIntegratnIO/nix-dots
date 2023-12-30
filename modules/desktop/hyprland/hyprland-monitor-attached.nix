# FILEPATH: /home/boboysdadda/Projects/nix-dots/modules/desktop/hyprland/hyprland-monitor-attach.nix
{pkgs, ...}: let
  hyprland-monitor-attached = import (
    pkgs.rustPlatform.buildRustPackage {
      name = "hyprland-monitor-attach";
      src = pkgs.fetchFromGitHub {
        owner = "coffebar";
        repo = "hyprland-monitor-attached";
        rev = "0.1";
        sha256 = "sha256-CY6Tv2ATZHXRU/I2n9UH2lHF0F+TC7X5U4yZ5iY9QC0="; # Replace with the actual SHA256 hash of the package
      };
      cargoHash = "sha256-cEeQnkWoGJT/FmT3h10vEErota7kTgrPgib3ZiiVWv4="; # Replace with the actual SHA256 hash of the Cargo.lock file
    }
  );
in {
  # Your Nix expressions here
  config = {
    environment.systemPackages = with pkgs; [
      hyprland-monitor-attached
    ];
  };
}
