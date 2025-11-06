{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.themes;
in {
  options.desktop.themes = {
    enable = mkEnableOption "desktop themes";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dracula-theme
      catppuccin-gtk
      catppuccin-kvantum
      adwaita-qt
      adwaita-qt6
      qogir-theme
      nordic
      arc-theme
      numix-gtk-theme
    ];
  };
}
