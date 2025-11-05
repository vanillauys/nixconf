{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.system.home-manager;
in {
  options.system.home-manager = {
    enable = lib.mkEnableOption "enable home-manager";

    userName = lib.mkOption {
      default = "wihan";
      description = "username for home-manager";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "${cfg.userName}" = import ../../../home.nix;
      };
    };
  };
}