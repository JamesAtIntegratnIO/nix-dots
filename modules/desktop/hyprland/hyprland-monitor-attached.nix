{pkgs, ...}: let
  hyprland-monitor-attached = pkgs.stdenv.mkDerivation {
    nativeBuildInputs = with pkgs; [rustc cargo];
    name = "hyprland-monitor-attach";
    src = pkgs.fetchFromGitHub {
      owner = "coffebar";
      repo = "hyprland-monitor-attached";
      rev = "72551d6";
      sha256 = "sha256-McenpaoEjQIB709VlLkyVGoUwVoMe7TJPb8Lrh1efw8="; # Replace with the actual SHA256 hash of the package
    };
    buildPhase = ''
      cargo build --release --locked
    '';
    installPhase = ''
      cargo install --path . --root $out
    '';
    cargoSha256 = "sha256-cEeQnkWoGJT/FmT3h10vEErota7kTgrPgib3ZiiVWv4="; # Replace with the actual SHA256 hash of the Cargo.lock file
  };

  rokid-attached = pkgs.writeShellScriptBin "rokid-attached" (builtins.readFile ./rokid-attached.sh);
  rokid-detached = pkgs.writeShellScriptBin "rokid-detached" (builtins.readFile ./rokid-detached.sh);
in {
  # Your Nix expressions here
  config = {
    environment.systemPackages = with pkgs; [
      hyprland-monitor-attached
      rokid-attached
      rokid-detached
    ];
  };
}
