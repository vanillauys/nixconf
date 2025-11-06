{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.ssd;
in {
  options.hardware.ssd = {
    enable = mkEnableOption "SSD optimizations";
  };

  config = mkIf cfg.enable {
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 10;
    };

    fileSystems."/".options = ["noatime" "nodiratime"];
  };
}
