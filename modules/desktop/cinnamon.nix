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

    services.xserver.desktopManager.cinnamon.extraGSettingsOverrides = ''
      [org.cinnamon.desktop.interface]
      gtk-theme='Dracula'
      icon-theme='Papirus-Dark'
      cursor-theme='catppuccin-mocha-mauve-cursors'

      [org.cinnamon.desktop.wm.preferences]
      theme='Dracula'

      [org.cinnamon.theme]
      name='Dracula'
    '';

    environment.systemPackages = with pkgs; [
      ghostty
      sl
    ];
  };
}
