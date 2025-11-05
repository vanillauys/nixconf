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
      vscode
      jetbrains.idea-community
      # Add more IDEs like jetbrains.clion, etc.
    ];
  };
}
