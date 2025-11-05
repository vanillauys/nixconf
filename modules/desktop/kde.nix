{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.kde;
in {
  options.desktop.kde = {
    enable = mkEnableOption "KDE Plasma desktop environment";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      ghostty
      sl
    ];
  };
}
