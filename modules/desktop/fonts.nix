{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.desktop.fonts;
in {
  options.desktop.fonts = {
    enable = mkEnableOption "fonts configuration";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.hack
        nerd-fonts.meslo-lg
        roboto
        ubuntu-classic
        liberation_ttf
        dejavu_fonts
        font-awesome
      ];

      fontconfig = {
        defaultFonts = {
          monospace = ["JetBrainsMono" "Noto Color Emoji"];
          sansSerif = ["Noto Sans" "Noto Color Emoji"];
          serif = ["Noto Serif" "Noto Color Emoji"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };
  };
}
