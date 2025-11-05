{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.ides;
in {
  options.programs.ides = {
    enable = lib.mkEnableOption "enable IDE packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.webstorm
    ];
  };
}
