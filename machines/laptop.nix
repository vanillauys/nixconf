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
    ./../modules/system/home-manager.nix
    ./../modules/system/system.nix
    inputs.home-manager.nixosModules.default
  ];

  main-user.enable = true;
  main-user.userName = "wihan";
  system.home-manager.enable = true;
  system.home-manager.userName = "wihan";
  system.home-manager.development.enable = true;
  system.home-manager.ides.enable = true;
  system.system.enable = true;
  main-user.extraGroups = ["networkmanager" "wheel" "podman"];
}
