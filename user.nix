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
        extraGroups = ["wheel"];
        initialPassword = username;
      };
    };
  };
}
