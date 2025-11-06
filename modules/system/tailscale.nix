{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.networking.tailscale;
in {
  options.networking.tailscale = {
    enable = mkEnableOption "Tailscale VPN";

    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "Open firewall port for Tailscale";
    };
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = cfg.openFirewall;
    };
  };
}
