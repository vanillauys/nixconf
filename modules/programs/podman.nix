{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.podman;
in {
  options.programs.podman = {
    enable = mkEnableOption "Podman container runtime";

    dockerCompat = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Docker compatibility";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = cfg.dockerCompat;
      defaultNetwork.settings.dns_enabled = true;
    };

    virtualisation.containers.registries.search = [
      "docker.io"
    ];

    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
