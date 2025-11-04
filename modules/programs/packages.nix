{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    tmux
    wget
    python314
    libfprint-2-tod1-broadcom
    ananicy-rules-cachyos
    fastfetch
  ];
}
