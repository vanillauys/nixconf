{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.networking;
in {
  options.system.networking = {
    enable = mkEnableOption "networking configuration";
    hostName = mkOption {
      type = types.str;
      default = "nixos";
      description = "The hostname of the system";
    };
    networkmanager = mkOption {
      type = types.bool;
      default = true;
      description = "Enable NetworkManager";
    };
  };

  config = mkIf cfg.enable {
    networking.hostName = cfg.hostName;
    networking.networkmanager.enable = cfg.networkmanager;
  };
}
