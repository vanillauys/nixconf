{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.nix;
in {
  options.system.nix = {
    enable = mkEnableOption "Nix configuration";

    gc = {
      automatic = mkOption {
        type = types.bool;
        default = true;
        description = "Enable automatic garbage collection";
      };
      dates = mkOption {
        type = types.str;
        default = "weekly";
        description = "When to run garbage collection";
      };
      options = mkOption {
        type = types.str;
        default = "--delete-older-than 7d";
        description = "Garbage collection options";
      };
    };

    optimise = {
      automatic = mkOption {
        type = types.bool;
        default = true;
        description = "Enable automatic store optimization";
      };
      dates = mkOption {
        type = types.listOf types.str;
        default = ["weekly"];
        description = "When to run store optimization";
      };
    };
  };

  config = mkIf cfg.enable {
    nix.settings.experimental-features = ["nix-command" "flakes"];

    nix.gc = {
      automatic = cfg.gc.automatic;
      dates = cfg.gc.dates;
      options = cfg.gc.options;
    };

    nix.optimise = {
      automatic = cfg.optimise.automatic;
      dates = cfg.optimise.dates;
    };
  };
}
