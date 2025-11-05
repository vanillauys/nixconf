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
    ./../modules/system/home-manager.nix
    ./../modules/system/system.nix
    inputs.home-manager.nixosModules.default
  ];

  main-user.enable = true;
  main-user.userName = "wihan";
  programs.development.enable = true;
  programs.ides.enable = true;
  system.home-manager.enable = true;
  system.home-manager.userName = "wihan";
  system.system.enable = true;
  main-user.extraGroups = ["networkmanager" "wheel" "podman"];
  main-user.packages = with pkgs; [
    neovim
    fzf
    _1password-gui
    _1password-cli
    temurin-bin
    bun
    cbonsai
    dracula-theme
  ];


    users = {
      "wihan" = import ./../home.nix;
    };
  };


}