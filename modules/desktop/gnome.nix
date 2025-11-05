{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.gnome;
in {
  options.desktop.gnome = {
    enable = mkEnableOption "GNOME desktop environment";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      ghostty
      sl
    ];
  };
}
