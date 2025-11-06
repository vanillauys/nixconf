{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.power;
in {
  options.hardware.power = {
    enable = mkEnableOption "power management";

    laptop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable laptop-specific power optimizations (TLP)";
    };
  };

  config = mkIf cfg.enable {
    services.tlp = mkIf cfg.laptop {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    powerManagement = {
      enable = true;
      cpuFreqGovernor = mkIf (!cfg.laptop) "schedutil";
    };

    services.upower.enable = true;
  };
}
