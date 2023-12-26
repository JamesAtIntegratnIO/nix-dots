{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  inherit (config.modules) graphics;
  cfg = config.modules.browser;
  username = import ../../username.nix;
in {
  imports = [
    ./options.nix
  ];
  config = mkMerge [
    (
      mkIf (cfg.firefox && (graphics.type != null)) {
        programs.firefox = {
          enable = true;
          preferencesStatus = "default";
          # Read more about policies here: https://github.com/mozilla/policy-templates/blob/master/README.md
          policies = {
            # To get extension details navigate to `manage extensions` > `cog wheel` > `debug addons`. You can find the info there
            Certificates = {
              ImportEnterpriseRoots = true;
              Install = [
                config.age.secrets.pfsense_ca.path
              ];
            };
            ExtensionSettings = {
              "uBlock0@raymondhill.net" = {
                installation_mode = "force_installed";
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              };
              "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
                installation_mode = "force_installed";
                install_url = "https://addons.mozilla.org/firefox/downloads/file/3918810/1password-latest-fx.xpi";
              };
              "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack" = {
                installation_mode = "force_installed";
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4040837/raindropio-latest.xpi";
              };
            };
            ExtensionUpdate = true;
            OfferToSaveLogins = false;
            DisableTelemetry = true;
            DNSOverHTTPS = {
              Enabled = false;
            };
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
              Value = true;
              Cryptomining = true;
              Fingerprinting = true;
              Exceptions = [];
            };
            FirefoxHome = {
              Search = true;
              TopSites = false;
              SponsoredTopSites = false;
              Highlights = false;
              Pocket = false;
              SponsoredPocket = false;
              Snippets = false;
            };
            NetworkPrediction = false;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            PasswordManagerEnabled = false;
            ShowHomeButton = true;
            StartDownloadsInTempDirectory = true;
          };
        };
      }
    )
  ];
}
