{lib, ...}:
with lib; {
  imports = [
    ./hyprland
    ./rofi
    ./theme
    ./waybar
    ./options.nix
  ];
}
