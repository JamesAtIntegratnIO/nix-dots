{
  config,
  pkgs,
  ...
}: let
  username = import ./work-username.nix;
in {
  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "video" "networkmanager" "docker" "libvirt"];
        initialPassword = username;
      };
    };
  };
}
