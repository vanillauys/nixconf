{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.usbMedia;
in {
  options.hardware.usbMedia = {
    enable = mkEnableOption "USB media and phone connectivity";

    mtp = mkOption {
      type = types.bool;
      default = true;
      description = "Enable MTP (Media Transfer Protocol) for Android devices";
    };

    gphoto = mkOption {
      type = types.bool;
      default = true;
      description = "Enable gPhoto2 for camera support";
    };
  };

  config = mkIf cfg.enable {
    # MTP support for Android phones
    services.gvfs = mkIf cfg.mtp {
      enable = true;
      package = pkgs.gvfs;
    };

    # gPhoto2 for cameras and some phones
    services.udev.packages = mkIf cfg.gphoto [pkgs.libgphoto2];

    environment.systemPackages = with pkgs;
      (optionals cfg.mtp [
        jmtpfs
        libmtp
        android-file-transfer
      ])
      ++ (optionals cfg.gphoto [
        gphoto2
        gphoto2fs
      ]);

    # USB automount
    services.udisks2.enable = true;
  };
}
