{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.fingerprint;
in {
  options.hardware.fingerprint = {
    enable = mkEnableOption "fingerprint authentication";
  };

  config = mkIf cfg.enable {
    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-broadcom;
      };
    };
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.login.fprintAuth = true;

    # Cinnamon
    security.pam.services.lightdm.fprintAuth = mkIf config.desktop.cinnamon.enable true;
    security.pam.services.cinnamon-screensaver.fprintAuth = mkIf config.desktop.cinnamon.enable true;

    # KDE
    security.pam.services.sddm.fprintAuth = mkIf config.desktop.kde.enable true;
    security.pam.services.kde.fprintAuth = mkIf config.desktop.kde.enable true;

    # GNOME
    security.pam.services.gdm.fprintAuth = mkIf config.desktop.gnome.enable true;
    security.pam.services.gnome-screensaver.fprintAuth = mkIf config.desktop.gnome.enable true;

    # Hyprland (uses swaylock or similar)
    security.pam.services.swaylock.fprintAuth = mkIf config.desktop.hyprland.enable true;
  };
}
