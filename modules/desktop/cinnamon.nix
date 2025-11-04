{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  environment.systemPackages = with pkgs; [
    ghostty
  ];
}
