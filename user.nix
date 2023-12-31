{
  config,
  pkgs,
  ...
}: let
  username = import ./username.nix;
in {
  users = {
    users = {
      root = {
        initialPassword = "root";
      };
      ${username} = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "video" "networkmanager" "docker" "libvirt"];
        initialPassword = username;
      };
    };
  };
}
