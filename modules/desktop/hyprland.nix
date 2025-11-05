{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = mkEnableOption "Hyprland wayland compositor";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      waybar
      wofi
      dunst
      ghostty
      sl
    ];
  };
}
