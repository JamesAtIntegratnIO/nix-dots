{lib, ...}:
with lib; {
  imports = [
    ./hyprland
    ./theme
    ./waybar
    ./options.nix
  ];
}
