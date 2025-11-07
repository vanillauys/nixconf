{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../hardware-configuration-desktop.nix
    ./../main-user.nix
    ./../modules
    inputs.home-manager.nixosModules.default
  ];
  # system
  system.system.enable = true;
  system.nix.enable = true;
  system.swap.enable = true;
  system.swap.sizeGB = 32;
  system.networking.enable = true;
  system.networking.hostName = "nixos";
  system.locale.enable = true;
  # Use defaults (ZA), or override:
  # system.locale.timeZone = "Europe/London";
  # system.locale.defaultLocale = "en_GB.UTF-8";
  # tailscale
  networking.tailscale.enable = true;
  # user
  main-user.enable = true;
  main-user.userName = "wihan";
  main-user.extraGroups = ["networkmanager" "wheel" "podman"];
  # home
  system.home-manager.enable = true;
  system.home-manager.userName = "wihan";
  # development
  system.home-manager.development.enable = true;
  system.home-manager.ides.enable = true;
  system.home-manager.development.languages.rust = false;
  system.home-manager.development.cloud.gcloud = true;
  system.home-manager.development.cloud.aws = false;
  system.home-manager.development.communication.slack = true;
  # desktop environment
  desktop.cinnamon.enable = true;
  #  desktop.kde.enable = false;
  #  desktop.gnome.enable = false;
  #  desktop.hyprland.enable = false;
  desktop.fonts.enable = true;
  desktop.icons.enable = true;
  desktop.themes.enable = true;
  desktop.xserver.enable = true; # Required for Cinnamon and GNOME
  # hardware
  hardware.fingerprint.enable = false;
  hardware.nvidia.enable = true;
  hardware.bluetooth.enable = true;
  hardware.audio.enable = true;
  hardware.audio.backend = "jack"; # or "pipewire"
  hardware.power.enable = true;
  hardware.power.laptop = false;
  hardware.ssd.enable = true;
  hardware.usbMedia.enable = true;
  # services
  services.printing.enable = true;
  services.firewall.enable = true;
  services.firewall.allowedTCPPorts = [22 80 443];
  services.firewall.allowedUDPPorts = [];
  # programs
  programs.media.enable = true;
  programs.media.players = ["all"]; # or ["vlc"] or ["mpv"]
  programs.podman.enable = true;
  programs.packages.enable = true;
  programs.packages.extraPackages = with pkgs; [
    # any other packages
  ];
  # 1password
  programs.onepassword.enable = true;
  programs.onepassword.polkitPolicyOwners = ["wihan"];
}
