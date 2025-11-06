{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.cinnamon;
in {
  options.desktop.cinnamon = {
    enable = mkEnableOption "Cinnamon desktop environment";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
  };
}
