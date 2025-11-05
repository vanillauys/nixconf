{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../hardware-configuration-desktop.nix
    ./../main-user.nix
    inputs.home-manager.nixosModules.default
  ];

  # system
  system.system.enable = true;
  system.nix.enable = true;
  system.swap.enable = true;
  system.swap.sizeGB = 32;
  # user
  main-user.enable = true;
  main-user.userName = "wihan";
  main-user.extraGroups = ["networkmanager" "wheel" "podman"];
  # home
  system.home-manager.enable = true;
  system.home-manager.userName = "wihan";
  system.home-manager.development.enable = true;
  system.home-manager.ides.enable = true;
  # desktop environment
  desktop.cinnamon.enable = true;
  #  desktop.kde.enable = false;
  #  desktop.gnome.enable = false;
  #  desktop.hyprland.enable = false;
  desktop.fonts.enable = true;
  desktop.icons.enable = true;
  desktop.xserver.enable = true; # Required for Cinnamon and GNOME
  # fingerprint sensor
  hardware.fingerprint.enable = false;
  # nvidia drivers
  hardware.nvidia.enable = true;
  # bluetooth
  hardware.bluetooth.enable = true;
  # audio
  hardware.audio.enable = true;
  hardware.audio.backend = "jack"; # or "pipewire"
  # networking
  system.networking.enable = true;
  system.networking.hostName = "nixos";
  # printing
  services.printing.enable = true;
  # podman (docker)
  programs.podman.enable = true;
  # system packages
  programs.packages.enable = true;
  programs.packages.extraPackages = with pkgs; [
    # any other packages
  ];
  # 1password
  programs.onepassword.enable = true;
  programs.onepassword.polkitPolicyOwners = ["wihan"];
}
