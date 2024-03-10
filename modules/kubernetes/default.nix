{lib, ...}:
with lib; {
  imports = [
    ./options.nix
    ./server.nix
    ./worker.nix
  ];
}
