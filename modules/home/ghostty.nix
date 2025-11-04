{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  xdg.configFile."ghostty/config".text = ''
    # Font configuration
    font-family = JetBrains Mono
    font-size = 12
    
    # Window configuration
    window-padding-x = 10
    window-padding-y = 10
    
    # Shell
    command = ${pkgs.zsh}/bin/zsh
  '';

  catppuccin.ghostty = {
    enable = true;
    flavor = "mocha";
  };
}
