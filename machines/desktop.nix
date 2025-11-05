{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./../hardware-configuration-desktop.nix  # Uncomment and create if needed
    ./../main-user.nix
    ./../modules/system/boot.nix
    ./../modules/system/networking.nix
    ./../modules/system/locale.nix
    ./../modules/system/nix.nix
    ./../modules/system/swap.nix
    ./../modules/hardware/audio.nix
    ./../modules/hardware/bluetooth.nix
    # ./../modules/hardware/fingerprint.nix  # Maybe not for desktop
    ./../modules/desktop/xserver.nix
    ./../modules/desktop/cinnamon.nix  # Or change to kde if module exists
    ./../modules/desktop/fonts.nix
    ./../modules/desktop/icons.nix
    ./../modules/services/printing.nix
    ./../modules/programs/shell.nix
    ./../modules/programs/packages.nix
    ./../modules/programs/1password.nix
    ./../modules/programs/podman.nix
    ./../modules/programs/development.nix
    ./../modules/programs/ides.nix
    ./../modules/hardware/nvidia.nix
    inputs.home-manager.nixosModules.default
  ];

  main-user.enable = true;
  main-user.userName = "wihan";
  programs.development.enable = true;
  programs.ides.enable = true;
  hardware.nvidia.enable = true;

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
      # Add desktop-specific packages here
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