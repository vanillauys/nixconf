{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "wihan";
  home.homeDirectory = "/home/wihan";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./modules/home/shell.nix
    ./modules/home/git.nix
    ./modules/home/ssh.nix
    ./modules/home/tmux.nix
    ./modules/home/grok.nix
    ./modules/home/packages.nix
    ./modules/home/ghostty.nix
    ./modules/home/podman.nix
    ./modules/home/gcloud.nix
    ./modules/home/brave.nix
    ./modules/home/development.nix
    ./modules/home/cursors.nix
  ];

  programs.home-manager.enable = true;
}
