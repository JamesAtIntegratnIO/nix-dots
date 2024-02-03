{lib, ...}:
with lib; {
  imports = [
    ./hyprland
    ./waybar
    ./options.nix
  ];
}
