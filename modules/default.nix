{
  imports = [
    # System
    ./system/boot.nix
    ./system/home-manager.nix
    ./system/locale.nix
    ./system/networking.nix
    ./system/nix.nix
    ./system/swap.nix
    ./system/system.nix
    ./system/firewall.nix
    # Hardware
    ./hardware/audio.nix
    ./hardware/fingerprint.nix
    ./hardware/nvidia.nix
    ./hardware/power.nix
    ./hardware/ssd.nix
    # Desktop
    ./desktop/cinnamon.nix
    ./desktop/kde.nix
    ./desktop/gnome.nix
    ./desktop/hyprland.nix
    ./desktop/fonts.nix
    ./desktop/icons.nix
    ./desktop/themes.nix
    ./desktop/xserver.nix
    # Programs
    ./programs/1password.nix
    ./programs/packages.nix
    ./programs/podman.nix
    ./programs/shell.nix
    ./programs/media.nix
  ];
}
