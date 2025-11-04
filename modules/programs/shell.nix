{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.neovim.defaultEditor = true;
}
