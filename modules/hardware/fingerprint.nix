{
  config,
  lib,
  pkgs,
  ...
}: {
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-broadcom;
    };
  };

  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.lightdm.fprintAuth = true;
  security.pam.services.cinnamon-screensaver.fprintAuth = true;
}
