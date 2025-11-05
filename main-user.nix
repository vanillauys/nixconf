{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.main-user;
in {
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "wihan";
      description = "username";
    };

    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["networkmanager" "wheel"];
      description = "extra groups for the user";
    };

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "packages to install for the user";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "12345678";
      description = cfg.userName;
      shell = pkgs.zsh;
      extraGroups = cfg.extraGroups;
      packages = cfg.packages;
    };
  };
}
