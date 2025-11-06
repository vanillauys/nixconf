{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.locale;
in {
  options.system.locale = {
    enable = mkEnableOption "locale configuration";

    timeZone = mkOption {
      type = types.str;
      default = "Africa/Johannesburg";
      description = "System timezone";
    };

    defaultLocale = mkOption {
      type = types.str;
      default = "en_ZA.UTF-8";
      description = "Default system locale";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;
    i18n.defaultLocale = cfg.defaultLocale;
  };
}
