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

    development = {
      enable = lib.mkEnableOption "enable development packages for home-manager";
    };

    ides = {
      enable = lib.mkEnableOption "enable IDEs for home-manager";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "${cfg.userName}" = {
          imports = [
            ../../home.nix
            {
              programs.development.enable = cfg.development.enable;
              programs.development.ides = cfg.ides.enable;
            }
          ];
        };
      };
    };
  };
}
