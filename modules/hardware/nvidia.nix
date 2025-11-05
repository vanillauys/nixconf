{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hardware.nvidia;
in {
  options.hardware.nvidia = {
    enable = lib.mkEnableOption "enable Nvidia drivers";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
