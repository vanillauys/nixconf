{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.xserver;
in {
  options.desktop.xserver = {
    enable = mkEnableOption "X server configuration";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "za";
        variant = "";
      };
    };
    services.libinput.enable = true;
  };
}
