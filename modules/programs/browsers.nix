{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.browsers;
in {
  options.programs.browsers = {
    enable = mkEnableOption "web browsers";

    default = mkOption {
      type = types.enum ["brave" "firefox" "chrome"];
      default = "brave";
      description = "Default browser";
    };

    brave = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Brave browser";
      };
    };

    firefox = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Firefox browser";
      };
    };

    chrome = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Google Chrome browser";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      (optionals cfg.brave.enable [brave])
      ++ (optionals cfg.firefox.enable [firefox])
      ++ (optionals cfg.chrome.enable [google-chrome]);

    # Set default browser
    xdg.mime.defaultApplications =
      mkIf (cfg.default == "brave") {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
      }
      // mkIf (cfg.default == "firefox") {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      }
      // mkIf (cfg.default == "chrome") {
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/about" = "google-chrome.desktop";
        "x-scheme-handler/unknown" = "google-chrome.desktop";
      };
  };
}
