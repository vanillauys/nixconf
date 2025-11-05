{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
}
