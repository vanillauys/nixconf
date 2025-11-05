{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../hardware-configuration.nix
    ./../main-user.nix
    ./../modules/system/boot.nix
    ./../modules/system/networking.nix
    ./../modules/system/locale.nix
    ./../modules/system/nix.nix
    ./../modules/system/swap.nix
    ./../modules/hardware/audio.nix
    ./../modules/hardware/bluetooth.nix
    ./../modules/hardware/fingerprint.nix
    ./../modules/desktop/xserver.nix
    ./../modules/desktop/cinnamon.nix
    ./../modules/desktop/fonts.nix
    ./../modules/desktop/icons.nix
    ./../modules/services/printing.nix
    ./../modules/programs/shell.nix
    ./../modules/programs/packages.nix
    ./../modules/programs/1password.nix
    ./../modules/programs/podman.nix
    ./../modules/programs/development.nix
    ./../modules/programs/ides.nix
    inputs.home-manager.nixosModules.default
  ];

  main-user.enable = true;
  main-user.userName = "wihan";
  programs.development.enable = true;
  programs.ides.enable = true;

  users.users.wihan = {
    isNormalUser = true;
    description = "wihan";
    extraGroups = ["networkmanager" "wheel" "podman"];
    packages = with pkgs; [
      neovim
      fzf
      _1password-gui
      _1password-cli
      temurin-bin
      bun
      cbonsai
      dracula-theme
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "wihan" = import ./../home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}