{pkgs, ...}: {
  imports = [
    ./browser
    ./containers
    ./desktop
    ./display-manager
    ./dev
    ./editor
    ./gaming
    ./graphics
    ./kubernetes
    ./media
    ./network
    ./security
    ./services
    ./social
    ./terminal
    ./virtualisation
  ];

  environment.systemPackages = with pkgs; [
    bash
    zsh
    fish
  ];
}
