{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    neovim
    tmux
    wget
    python314
    ananicy-rules-cachyos
    fastfetch
  ];
}
