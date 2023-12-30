{pkgs, ...}: {
  imports = [
    ./browser
    ./desktop
    ./display-manager
    ./dev
    ./editor
    ./graphics
    ./network
    ./security
    ./services
    ./social
    ./terminal
  ];

  environment.systemPackages = with pkgs; [
    bash
    zsh
    fish
  ];
}
