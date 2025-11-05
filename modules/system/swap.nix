{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.swap;
in {
  options.system.swap = {
    enable = mkEnableOption "swap file configuration";

    sizeGB = mkOption {
      type = types.int;
      default = 32;
      description = "Size of swap file in GB";
    };
  };

  config = mkIf cfg.enable {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = cfg.sizeGB * 1024;
      }
    ];
  };
}
