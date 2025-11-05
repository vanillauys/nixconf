{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.packages;
in {
  options.programs.packages = {
    enable = mkEnableOption "system packages";

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional packages to install";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        vim
        tmux
        wget
        git
        ananicy-rules-cachyos
        fastfetch
      ]
      ++ cfg.extraPackages;
  };
}
