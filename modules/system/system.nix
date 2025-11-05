{
  lib,
  config,
  ...
}: let
  cfg = config.system.system;
in {
  options.system.system = {
    enable = lib.mkEnableOption "enable system settings";

    allowUnfree = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "allow unfree packages";
    };

    stateVersion = lib.mkOption {
      default = "25.05";
      description = "system state version";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = cfg.allowUnfree;
    system.stateVersion = cfg.stateVersion;
  };
}