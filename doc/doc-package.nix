{
  lib,
  runCommand,
  nixosOptionsDoc,
  ...
}: let
  # evaluate our options
  eval = lib.evalModules {
    # Not needed to add options for native nix lib
    modules = [
      ../modules/browser/options.nix
      ../modules/containers/options.nix
      ../modules/desktop/options.nix
      ../modules/dev/options.nix
      ../modules/display-manager/options.nix
      ../modules/editor/options.nix
      ../modules/gaming/options.nix
      ../modules/graphics/options.nix
      ../modules/media/options.nix
      ../modules/network/options.nix
      ../modules/security/options.nix
      ../modules/services/options.nix
      ../modules/social/options.nix
      ../modules/terminal/options.nix
      ../modules/virtualisation/options.nix
    ];
  };
  # generate our docs
  optionsDoc = nixosOptionsDoc {
    options = eval.options.modules;
    transformOptions = o: o;
  };
in
  runCommand "index.md" {} ''
    cat ${optionsDoc.optionsCommonMark} >> $out
  ''
