{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.firewall;
in {
  options.services.firewall = {
    enable = mkEnableOption "firewall configuration";

    allowedTCPPorts = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of TCP ports to allow";
    };

    allowedUDPPorts = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of UDP ports to allow";
    };

    trustedInterfaces = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of trusted network interfaces";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = cfg.allowedTCPPorts;
      allowedUDPPorts = cfg.allowedUDPPorts;
      trustedInterfaces = cfg.trustedInterfaces;
      allowPing = true;
    };
  };
}
