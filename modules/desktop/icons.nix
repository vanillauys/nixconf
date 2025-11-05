{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.icons;
in {
  options.desktop.icons = {
    enable = mkEnableOption "icon themes";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      papirus-icon-theme
      dracula-icon-theme
      numix-icon-theme
      arc-icon-theme
      adwaita-icon-theme
    ];
  };
}
